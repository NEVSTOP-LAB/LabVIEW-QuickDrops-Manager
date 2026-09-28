# AIXML 与 VI Scripting 事实清单

## AIXML 语法

- 每个元素都要 `uid`；顶层元素加 `uid_parent="root"`。
- `<Control>` / `<Indicator>` 必须带 `value`，缺了校验报 `Error -2628 解析文档失败`（症状像「节点不支持」，容易误判）。
- 类引用常量写 `ref{LV.X}`；只写 `{LV.X}` 报 "Unrecognized or unsupported attribute set in Constant"。
- 字符串 / 路径常量里的反斜杠要双写；属性值里的 `>` 写 `&gt;`，同一个网名在产生端与消费端都要写成同样的转义形式。
- 连线名是「网」：同名即同一根线；扇出靠重复同一个网名。
- 跨结构边界（case / loop）必须显式写 `<Tunnel>`；case 的每个帧都要声明全部 tunnel，未用的写空 net。
- `For Loop`：N 用 `maxin` 指定；`count="<loopUid>.value"` 指循环自己的 `i`；`ShiftReg` 的 `Left` 是循环输出侧、`Right` 是输入侧，初值必须来自循环外（写进循环内会报环）。
- uid 用数字或字母开头的串，不要重复。
- 结构节点：`<Structure _name="Case Structure">` + `<CaseFrame selector="...">`；布尔 selector 用 `True` / `False`，错误簇用 `No Error` / `Error`。判断空字符串的 case（`Empty String/Path?`）True 帧是「空」，容易写反。
- `Constant` 的数组字面量形如 `[0,3,8,10,11]`，簇形如 `[false,0,]`。
- 属性节点用 `fields="read+X"` / `write+X`，并必须用 `type="{LV.类名}"` 声明所操作的类；属性名要照抄类文档（如 `Input Terminals` 无方括号、`Output Terminals[]` 有方括号）。
- Invoke 节点写成 `_name="Invoke Node"` + `target="方法名"` + `type="{LV.类名}"`；把 `_name` 写成方法名会报 "Unrecognized node type"。

## 生成与保存

- 先 `ValidateAIXML`；`ConvertAIXMLToVI` 可以覆盖已存在的文件（前提：同名 VI 不在内存中），并能顺带 `openVI` 打开。
- 保存目录必须先存在（LabVIEW 不建目录，报 `Error 7`）。
- 生成的 VI 默认**没有**连接器板端子：要在 `<Control>` / `<Indicator>` 上写 `conIdx`；pattern 由生成器按 conIdx 选择，不可预测。
- 每个新 VI 用新文件名，避免 1051 / 1357；生成后若无人持引用会自行卸载，因此同一路径可反复再生成。

## VI Scripting 要点

- 常用节点：`New VI Object`（`owner refnum` / `style` / `position,next to` / `error in` / `vi object class` / `auto wire? (F)` / `path` / `bounds`，终端要列全）、`To More Specific Class`、`Connect Wire`（`Wire Source` / `Auto Wire? (T)` / `Auto Route? (F)`）、`Delete`、`AddInputAfter`、`Save.Instrument`。
- 常用属性/方法：`Wires[]`、`Selection List[]`、`All Objects[]`（不含 wire）、`Terminals[]`、`Master Bounds Rect`、`Is Source?`、`Input Count` / `Output Count`、`Class Name`、`Style`。
- `New VI Object` 的 `style` 是 Ring，值 = 调色板 item ID 减两个字符：Bundle = 2049、Unbundle = 2048、Build Array = 2041。创建 Bundle/Unbundle 时 `vi object class` 传 `ref{LV.GrowableFunction}`，再用 `To More Specific Class` 转成 `ref{LV.Bundler}` / `ref{LV.Unbundler}`。
- Bundler 读 `Input Terminals`（有序，与元素顺序一致）；Unbundler 读 `Output Terminals[]`。
- `AddInputAfter(Index := Input Count - 1)` 只在节点已定型（已接源）后成功；在未接任何源的 Bundle 上运行时报 1055。正确顺序：先把前两个源接进 input 0 / 1 让它定型，再增长。
- 分叉的线在对象模型里是**一个** Wire（`Terminals[]` 有 3 个以上端子）；「每根线只有一个下游端子」的判定就是 `Array Size(Wire.Terminals[]) == 2`。
- `Selection List[]` 只读，既不能写也不能在无头环境设置；UI 选区无法脚本化。
- `Open VI Reference` 的 `vi path` 必须是 path 类型：直接接 string 会在运行时报 `Error 1004`（提示 path 未接），前面要加 `String To Path`。
- 前面板对象：`{LV.VI} Front Panel` → `{LV.Panel} All Objects[]`（顺序是声明顺序的反序）；`{LV.Control}` 可读 `Class Name`（如 `Cluster` / `Boolean` / `String` / `VIRefNum`）、`Indicator`、`Is On Connector Pane`（只读）。
- 连接器板对象：`{LV.ConnectorPane}` 有 `AssignCtrlToTerm(Control, TermIdx)`；它的 `Controls[]` 读出是 `1D array of void`，不可用；`{LV.VI} Connector Pane:Reference` 读出来不能喂给 `To More Specific Class`（报 bad terminal）。
- 用 `lvai_connector_pane` 测量连接器板：给出 pattern id、slot map、每个端子的位置与风格判定。**不同 pattern 的编号完全不同**（例如 `error in` 在 4815 上是 8，在 4833 上是 11），写 conIdx 前必须先测。

## 验证手段

- 无头运行：`lvai_run_vi_and_read_values`（只能写字符串控件；`errorCode` 是 helper 的，目标 VI 自己的错误要看它返回的 `error out`）。
- 读回代码：`lvai_convert_vi_to_aixml` 导出目标 VI 的 AIXML，核对节点与连接关系（`_name` 取文件名，与生成时的 `_name` 无关）。
- 断言版面/顺序：用 Win32 截图（`EnumWindows` 找窗口 → `ShowWindow(9)` + `SetForegroundWindow` → `PrintWindow(hwnd, hdc, 2)` 存 PNG）。用 `powershell.exe -NoProfile -ExecutionPolicy Bypass -File x.ps1` 跑，脚本写成文件再执行，别塞进 `-Command`。
