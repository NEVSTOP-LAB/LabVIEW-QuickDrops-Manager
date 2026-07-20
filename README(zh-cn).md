[English](README.md) | [中文](README(zh-cn).md)

# LabVIEW QuickDrops Manager

<a href="https://www.vipm.io/package/labview_quickdrops_manager/"> <img src="https://www.vipm.io/package/labview_quickdrops_manager/badge.svg?metric=installs"></a>
<a href="https://www.vipm.io/package/labview_quickdrops_manager/"><img src="https://www.vipm.io/package/labview_quickdrops_manager/badge.svg?metric=stars"></a>
[![GitHub all releases](https://img.shields.io/github/downloads/NEVSTOP-LAB/LabVIEW-QuickDrops-Manager/total)](https://github.com/NEVSTOP-LAB/LabVIEW-QuickDrops-Manager/releases)
[![Check_Broken_VIs](https://github.com/NEVSTOP-LAB/LabVIEW-QuickDrops-Manager/actions/workflows/Check_Broken_VIs.yml/badge.svg)](https://github.com/NEVSTOP-LAB/LabVIEW-QuickDrops-Manager/actions/workflows/Check_Broken_VIs.yml)
[![Build_VIPM_Library](https://github.com/NEVSTOP-LAB/LabVIEW-QuickDrops-Manager/actions/workflows/Build_VIPM_Library.yml/badge.svg)](https://github.com/NEVSTOP-LAB/LabVIEW-QuickDrops-Manager/actions/workflows/Build_VIPM_Library.yml)
[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

**LabVIEW QuickDrops Manager** 本身也是一个 QuickDrop 插件，用于高效管理你的所有 QuickDrop 快捷操作。无需为每个 QuickDrop 分配快捷键并记住它们，只需输入关键词即可搜索并执行你想要的操作。该工具额外内置了多个实用的 QuickDrop 插件，覆盖 VI 排列、控件操作、代码生成等场景。

![image](https://user-images.githubusercontent.com/8196752/82533027-11c7b100-9b75-11ea-9739-a7f55656611a.png)

## 特性

1. **拖拽绑定** — 从 QD 列表直接拖拽到按键上，快速修改快捷键映射。
2. **关键词搜索** — 无需为每个 QD 分配快捷键，输入关键词即可搜索并执行任意已安装的 QD。
3. **使用计数** — 自动统计每个 QD 的使用次数，帮助你了解哪些工具最常用。
4. **丰富的内置插件** — 集成对齐分布、数组/簇引用构建、状态机生成、结构着色、窗口排列等实用工具。

## 内置 QuickDrop 插件

### QD_Align&amp;Distribute（对齐与分布）
提供对齐（左/右/上/下/水平居中/垂直居中）和分布（水平/垂直间距、压缩、居中）等 16 种操作，一键整理面板控件布局。

### QD_Arrange VI Window（排列 VI 窗口）
将 VI 的前面板和程序框图窗口按预设布局自动排列，适合多屏或分屏工作流。

### QD_Build Array of References（构建引用数组）
快速将选中的多个对象转换为引用数组，便于批量操作。

### QD_Build Cluster of References（构建引用簇）
类似数组版本，但输出为引用簇，适用于异构控件集合。

### QD_Cluster AutoSizing（簇自动调整大小）
自动调整簇（Cluster）的大小以匹配其包含的元素，避免手动拖拽调整。

### QD_ColourUpStructures（结构着色）
为选中的结构（While 循环、For 循环、条件结构等）自动填充颜色，提升代码可读性。

### QD_Controls Operation（控件操作）
提供控件的批量操作功能，如隐藏/显示、禁用/启用等。

### QD_Create a Place VI Contents（创建占位 VI 内容）
在程序框图中快速生成占位内容或模板代码。

### QD_Erease Data（擦除数据）
一键清除前面板控件的数据，恢复到默认值，方便测试。

### QD_Fit Window to Content（窗口适应内容）
自动调整 VI 窗口大小以完美适应其内容。

### QD_NEVSTOP QD Shortcuts（NEVSTOP 快捷方式）
弹出快捷方式选择对话框，集中管理所有 NEVSTOP 自定义快捷操作。

### QD_Remove Unused Terminals On Nodes（移除节点未用端子）
自动移除函数/VI 节点上未连接的输入/输出端子，简化程序框图。

### QD_Smart Open VI Location（智能打开 VI 位置）
在资源管理器中智能定位并打开 VI 所在的文件夹。

### QD_State Machine From Enum（从枚举生成状态机）
根据枚举类型自动生成状态机框架代码，加速状态机编程。

### QD_While Loop Subdiagram Label（While 循环子图解标签）
为 While 循环添加子图解标签，提升代码文档化。

## 默认快捷键映射

| 按键 | 映射 |
|:---:|---|
| `A` | `[Ctrl]` 对齐与分布（Align and Distribute） |
| `B` | `[Ctrl]` 构建引用数组（Build Array of References） |
| `C` | _保留_ |
| `D` | `[LabVIEW 内置]` `[Ctrl]` 连线所有端子（Wire All Terminals） |
| `E` | `[Ctrl]` 擦除数据（Erease Data） |
| `F` | `[Ctrl]` 排列 VI 窗口（Arrange VI Window） |
| `G` | `[Ctrl]` `[Shift]` 创建占位 VI 内容（Create a Place VI Contents） |
| `H` | _保留_ |
| `I` | `[LabVIEW 内置]` `[Ctrl]` `[Shift]` 插入（Insert） |
| `J` | _保留_ |
| `K` | _保留_ |
| `L` | _保留_ |
| `M` | _保留_ |
| `N` | _保留_ |
| `O` | `[Ctrl]` 智能打开 VI 位置（Smart Open VI Location） |
| `P` | `[LabVIEW 内置]` `[Ctrl]` 替换（Replace） |
| `Q` | `[Ctrl]` NEVSTOP QD 快捷方式（NEVSTOP QD Shortcuts） |
| `R` | `[LabVIEW 内置]` `[Ctrl]` 移除并重连（Remove And Rewire） |
| `S` | `[Ctrl]` 从枚举生成状态机（State Machine from Enum） |
| `T` | `[LabVIEW 内置]` `[Ctrl]` `[Shift]` 移动标签（Move Labels） |
| `U` | `[Ctrl]` `[Shift]` 簇自动调整大小（Cluster Auto-Sizing） |
| `V` | _保留_ |
| `W` | `[LabVIEW 内置]` `[Ctrl]` `[Shift]` 连线多个对象（Wire Multiple Objects Together） |
| `X` | _保留_ |
| `Y` | _保留_ |
| `Z` | _保留_ |

> `[LabVIEW 内置]` 表示该操作为 LabVIEW 自带的 QuickDrop 功能，本工具保留其映射不变。

## 开发环境

- LabVIEW 2017
- VIPM 2020.3

## 安装

### 通过 VIPM 安装（推荐）

在 VIPM 中搜索 `labview_quickdrops_manager` 或访问以下链接直接安装：

[https://www.vipm.io/package/labview_quickdrops_manager/](https://www.vipm.io/package/labview_quickdrops_manager/)

### 手动安装

1. 克隆或下载本仓库。
2. 打开 `LabVIEW-QuickDrops-Manager.lvproj` 项目文件。
3. 将 `src/user.lib/` 下的内容复制到 LabVIEW 的 `user.lib` 目录。
4. 将 `src/resource/` 下的内容复制到 `LabVIEW-QuickDrops-Manager` 资源目录。
5. 重启 LabVIEW，即可在 QuickDrop 中使用。

## 更多信息

- **Wiki**: [https://github.com/NEVSTOP-LAB/LabVIEW-QuickDrops-Manager/wiki](https://github.com/NEVSTOP-LAB/LabVIEW-QuickDrops-Manager/wiki)
- **Issues**: [https://github.com/NEVSTOP-LAB/LabVIEW-QuickDrops-Manager/issues](https://github.com/NEVSTOP-LAB/LabVIEW-QuickDrops-Manager/issues)
- **Release**: [https://github.com/NEVSTOP-LAB/LabVIEW-QuickDrops-Manager/releases](https://github.com/NEVSTOP-LAB/LabVIEW-QuickDrops-Manager/releases)

## 许可证

[Apache License 2.0](https://opensource.org/licenses/Apache-2.0)
