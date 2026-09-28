#requires -Version 5.1
<#
lv-dialog-guard.ps1 — 监视 LabVIEW 的模态对话框并自动置前 + 回车。

背景：LabVIEW 弹出模态对话框时，labview-mcp 的 AI gRPC 服务会被整块冻结，
所有 lvai_* 调用一律超时（DeadlineExceeded），但 LabVIEW 界面看起来正常。
本脚本常驻后台，检测到对话框就自动点掉，并把命中记录写进日志。

用法：
  pwsh -NoProfile -ExecutionPolicy Bypass -File lv-dialog-guard.ps1
  pwsh -NoProfile -ExecutionPolicy Bypass -File lv-dialog-guard.ps1 -Once
  pwsh -NoProfile -ExecutionPolicy Bypass -File lv-dialog-guard.ps1 -DryRun -MaxWidth 700 -MaxHeight 500

判定规则：
  属于目标进程（默认 LabVIEW）的可见顶层窗口，满足任一即为对话框：
    1. 窗口类名为 #32770（标准对话框）；
    2. 窗口尺寸不超过 -MaxWidth x -MaxHeight 且有标题（LabVIEW 自绘的小提示窗走这条）。
#>
param(
    [double]$IntervalSeconds = 1,
    [int]$MaxWidth = 700,
    [int]$MaxHeight = 500,
    [int]$CooldownSeconds = 3,
    [string]$ProcessName = 'LabVIEW',
    [string]$LogPath = (Join-Path $env:TEMP 'lv-dialog-guard.log'),
    [switch]$Once,
    [switch]$DryRun
)

Add-Type -AssemblyName System.Windows.Forms
Add-Type @"
using System;
using System.Runtime.InteropServices;
using System.Text;
public class LVGuard {
  public delegate bool EnumProc(IntPtr hWnd, IntPtr lParam);
  [DllImport("user32.dll")] public static extern bool EnumWindows(EnumProc cb, IntPtr lParam);
  [DllImport("user32.dll", CharSet=CharSet.Unicode)] public static extern int GetWindowTextW(IntPtr hWnd, StringBuilder s, int n);
  [DllImport("user32.dll", CharSet=CharSet.Unicode)] public static extern int GetClassNameW(IntPtr hWnd, StringBuilder s, int n);
  [DllImport("user32.dll")] public static extern bool IsWindowVisible(IntPtr hWnd);
  [DllImport("user32.dll")] public static extern int GetWindowThreadProcessId(IntPtr hWnd, out int pid);
  [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr hWnd, int cmd);
  [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr hWnd);
  [DllImport("user32.dll")] public static extern bool GetWindowRect(IntPtr hWnd, out RECT r);
  public struct RECT { public int Left, Top, Right, Bottom; }
}
"@

$script:logEnc = New-Object System.Text.UTF8Encoding($false)

function Write-GuardLog {
    param([string]$Message)
    $line = '{0} {1}' -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), $Message
    Write-Host $line
    try { [System.IO.File]::AppendAllText($LogPath, $line + [Environment]::NewLine, $script:logEnc) } catch { }
}

function Get-TargetWindows {
    param([int[]]$Pids)
    $found = New-Object System.Collections.ArrayList
    [LVGuard]::EnumWindows({
            param($hWnd, $lParam)
            if (-not [LVGuard]::IsWindowVisible($hWnd)) { return $true }

            $procId = 0
            [void][LVGuard]::GetWindowThreadProcessId($hWnd, [ref]$procId)
            if ($Pids -notcontains $procId) { return $true }

            $titleSb = New-Object System.Text.StringBuilder 512
            [void][LVGuard]::GetWindowTextW($hWnd, $titleSb, 512)
            $title = $titleSb.ToString().Replace("`r", ' ').Replace("`n", ' ')
            if ([string]::IsNullOrWhiteSpace($title)) { return $true }

            $classSb = New-Object System.Text.StringBuilder 256
            [void][LVGuard]::GetClassNameW($hWnd, $classSb, 256)

            $rect = New-Object LVGuard+RECT
            [void][LVGuard]::GetWindowRect($hWnd, [ref]$rect)
            $w = $rect.Right - $rect.Left
            $h = $rect.Bottom - $rect.Top
            if ($w -le 0 -or $h -le 0) { return $true }

            $isStdDialog = ($classSb.ToString() -eq '#32770')
            $isSmallPopup = ($w -le $MaxWidth -and $h -le $MaxHeight)

            # 排除 LabVIEW 正常的窗口（小尺寸的前面板/框图等），避免误按回车
            $isNormalWindow = $title -match '(?i)front panel|block diagram|project explorer|getting started|icon editor'

            if (-not $isNormalWindow -and ($isStdDialog -or $isSmallPopup)) {
                [void]$found.Add([pscustomobject]@{
                        Handle = $hWnd
                        Pid    = $procId
                        Class  = $classSb.ToString()
                        Title  = $title
                        Width  = $w
                        Height = $h
                        Kind   = $(if ($isStdDialog) { 'dialog(#32770)' } else { 'small-window' })
                    })
            }
            return $true
        }, [IntPtr]::Zero) | Out-Null
    return $found
}

Write-GuardLog ("guard started: process={0} interval={1}s maxsize={2}x{3} cooldown={4}s dryrun={5} log={6}" -f $ProcessName, $IntervalSeconds, $MaxWidth, $MaxHeight, $CooldownSeconds, $DryRun, $LogPath)

$cooldown = @{}
$round = 0

while ($true) {
    $round++
    $procs = @(Get-Process -Name $ProcessName -ErrorAction SilentlyContinue)
    if ($procs.Count -eq 0) {
        if ($round % 30 -eq 1) { Write-GuardLog ("no {0} process; waiting" -f $ProcessName) }
    }
    else {
        $pids = @($procs | ForEach-Object { $_.Id })
        foreach ($win in (Get-TargetWindows -Pids $pids)) {
            $key = [string]$win.Handle
            if ($cooldown.ContainsKey($key)) {
                if (((Get-Date) - $cooldown[$key]).TotalSeconds -lt $CooldownSeconds) { continue }
            }
            $cooldown[$key] = Get-Date

            $desc = '[{0}] hwnd=0x{1:X} {2}x{3} "{4}"' -f $win.Kind, [int64]$win.Handle, $win.Width, $win.Height, $win.Title
            if ($DryRun) {
                Write-GuardLog ('would dismiss ' + $desc)
                continue
            }

            [void][LVGuard]::ShowWindow($win.Handle, 9)
            [void][LVGuard]::SetForegroundWindow($win.Handle)
            Start-Sleep -Milliseconds 300
            try {
                [System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
                Write-GuardLog ('dismissed ' + $desc)
            }
            catch {
                Write-GuardLog ('sendkeys failed ' + $desc + ' : ' + $_.Exception.Message)
            }
            Start-Sleep -Milliseconds 300
        }
        if ($round % 60 -eq 1) { Write-GuardLog ('watching {0} window(s) of {1} process(es)' -f (Get-TargetWindows -Pids $pids).Count, $procs.Count) }
    }

    if ($Once) { break }
    Start-Sleep -Milliseconds ([int]($IntervalSeconds * 1000))
}

Write-GuardLog 'guard stopped'
