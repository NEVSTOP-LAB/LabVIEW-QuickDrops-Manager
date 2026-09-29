---
name: labview-quickdrop-plugin
description: "创建、修改或调试 LabVIEW QuickDrop 插件与配套 subVI。Use when: 需要按选区改造框图（连线、节点、簇、Bundle/Unbundle 等）, 需要用 labview-mcp 生成/校验/运行 VI, 需要判断生成的 VI 能否作为 subVI 接线, 需要设计可无头验证的插件 VI, 需要定位 labview-mcp 通讯卡死。"
argument-hint: '[插件功能或目标 VI，留空则从当前上下文提取]'
---

# LabVIEW QuickDrop 插件

## 硬性门禁：先起模态框看门狗

使用 labview-mcp 期间若 LabVIEW 弹出模态对话框，整个 AI gRPC 服务会被冻结：所有 `lvai_*` 调用一律超时（DeadlineExceeded），而 LabVIEW 界面本身看起来正常。因此：

- 动手前先在后台常驻 `scripts/lv-dialog-guard.ps1`：它发现属于 LabVIEW 的对话框（`#32770`）或小窗口就置前并回车，命中记录写入日志。
- 启动：`pwsh -NoProfile -ExecutionPolicy Bypass -File scripts/lv-dialog-guard.ps1`
- 已经卡住时先用该脚本解除；仍不通则按「服务未起」处理：用 `lvai_status` 探测，`lvai_ensure_labview` 只能拉起 IDE（gRPC 服务随 IDE 里的 NIGEL 一起启动，没开就不会监听任何端口）。

## 工具能力边界（决定方案形态）

- AIXML 只能**新建** VI；`ApplyAIXMLToVI` 对第三方客户端恒失败，因此**改不了现有 VI 的框图**——要改就得重新生成一个新文件。
- 生成的 VI 必须自包含：不能 Call 工程内/库内的 subVI，只能调调色板可达的 VI。
- AIXML 不能表达坐标与版面，节点位置由生成器决定。
- 要接线的端子**必须**在 AIXML 里写 `conIdx`；不写则成品一个连接器板端子都没有，无法作为 subVI 接线。生成后必须用 `lvai_connector_pane` 复测：pattern 由生成器挑，换 pattern 会移动全部编号。
- 保存目录需先存在；同名 VI 还在内存中会报 1051 / 1357。
- 先 `ValidateAIXML`（廉价失败路径）再 `ConvertAIXMLToVI`；生成后自检「被消费但从未产生」的连线名。
- `lvai_run_vi_and_read_values` 只能写入字符串控件；数组/簇以扁平 XML 返回；VI 被改动过要先保存再释放引用，否则改动丢失。

语法、节点、VI Scripting 的完整事实清单见 [references/aixml-and-scripting-facts.md](./references/aixml-and-scripting-facts.md)。

## 保存方决定 VI 版本（本仓库硬约束）

- CI（`Check_Broken_VIs`）在 **LabVIEW 2017** 上加载工作区内所有 VI；任何被更高版本保存过的 VI 都会报 `VI version (26.0) is newer than LabVIEW version (17.0)` 并让 CI 变红。改动现有 VI 前先确认保存它的是哪个 LabVIEW。
- `LabVIEW-QuickDrops-Manager.lvproj` 带 `NI.LV.All.SaveVersion = 17.0`：**该工程处于活动状态时**生成的 VI 才是 17.0 格式。会话开始前确认工程已激活，否则会产出 26.0 的 VI。
- `ConvertVIToAIXML` / `ConvertVIsToAIXML` **不是纯读**：对保存版本高于工程 SaveVersion 的 VI，它会按工程版本重写文件（实测 4 个 `NEVSTOP_QuickDrop/__QDMgr.vi` 因此在磁盘上被改成 17.0）。批量导出后要 `git status` 核对。
- AIXML 只能新建 VI、`ApplyAIXMLToVI` 对第三方客户端不可用，因此**改现有 VI 的描述**要另找保存方：生成一个 helper VI，用 `Open Application Reference` + `Open VI Reference`（`application reference (local)`）指向 2017 实例的 VI Server，写 `{LV.VI}` 的 `VI Description` 属性后 `Save:Instrument`，保存方即 2017，文件版本不变。helper 由 `RunVIAsTopLevel` 驱动时，**只有字符串指示器能回传**（布尔/数值静默变成空串，错误信息只看字符串型 `source`）。
- 内置原语（如 `Open Application Reference`、`Select`）的节点名与端子名不要猜：用 `SearchInfoCache` + `LookupInfoCacheItems` 取现成原型，端子名照抄（`machine name ("": open local reference)`、`Select` 的输出 `s? t\3Af`）。移位寄存器的线名要用左右端子自身的 uid，不是 ShiftReg 的 uid。

## 插件契约

- 插件放在 QuickDrop 的 `plugins/` 下，一插件一目录；用插件模板新建以取得标准连接器板：`error in` 8、`QD Launch VI Ref` 11、`Shift Pressed?` 7、`Variant in` 6、`QD Combo Box Ref` 10、`error out` 0、`Variant out` 4、`Undo Name` 无 conIdx。
- 选区来自「启动 QuickDrop 的那个 VI」：`QD Launch VI Ref` → `Block Diagram` → `Selection List[]`，再逐个 `To More Specific Class` 筛出需要的类型。
- Undo 事务由调用方（模板 / 管理器）负责：插件 VI 自己不开事务，出错时应让事务失败。
- NEVSTOP QuickDrops Manager：目录名 `QD_<名字>`；快捷键取自插件 VI 描述里的 `Default Shortcut - [X]` 行。
- 交付形态二选一：把 subVI 交给使用者接入模板（已验证可行）；或脚本化模板（复制模板 → 放 subVI → 连线 → 保存，未验证）。

## 可测试性设计（先定接口再动手）

- 不要依赖 UI 选区：`Selection List[]` 只读，且无头环境不可达。
- 固定套路：加一个「诊断路径」字符串输入（空=按选区；给路径=打开该 VI、对整图同类对象操作并保存）+ 一个 `changes made?` 布尔输出。每个功能因此都能无头跑真实数据。
- 收尾必须落到证据：跑一次读回值、导出目标 VI（`ConvertVIToAIXML`）核对连接关系、`lvai_connector_pane` 核对端子；要断言版面顺序时截图比对。

## 实施流程

1. **探针先行**：用最小探针 VI 证实不确定的 API 事实（类名、属性/方法是否存在、返回类型、是否可写），再写正式 VI。
2. **写 AIXML**：按参考清单的语法要点，`ValidateAIXML` 通过后生成到新文件名。
3. **端到端验证**：无头运行 + 导出目标 VI + 连接器板复测，逐条对齐验收标准；每修一处重新验证。
4. **交付**：附使用说明（端子与 conIdx、接入步骤、限制、验证记录），并写明 Undo 由谁负责。
