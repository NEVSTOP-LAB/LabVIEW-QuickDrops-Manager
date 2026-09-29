# Copilot Instructions

## 目录结构/版本管理

- **临时文件目录**：生成的临时文件放在 `.tmp/` 目录下, 不提交到版本控制系统
- **Wiki 目录**：`.wiki/` 是 GitHub Wiki 仓库（`NEVSTOP-LAB/LabVIEW-QuickDrops-Manager.wiki.git`）的 submodule，wiki 文档的修改在该目录内提交并推送
- **pr留言**：每完成一个阶段（一批提交）后，用 `gh pr status` 检查当前分支是否有关联的 open PR；若有关联，用 `gh pr comment` 留言本阶段修改的背景、内容与关键决策，并用 `gh pr edit --body-file` 总结 PR 修改描述
- **issue创建**：创建issue时，添加适当的标签以便分类和跟踪; 复杂问题中，需要有checkbox列表跟踪任务完成情况
- **issue留言**：如果上下文了解到是在处理issue，每完成一个阶段，在 issue 中留言相关的背景、内容与关键决策
- **修改前同步认知**：在进行修改前，确认是否完全理解需求，如果不清楚，采访用户直到理解全部的细节

## 文档

- **中英文一致**：README 与 wiki 的单个 QuickDrop 页均为「英文在前、一行 `-----`、中文在后」的单文件双语；中文是英文的逐节对应翻译，章节与要点必须一一对应，不允许一边多一边少，改动任一半后必须同步另一半（删除中文副本文档时同时清理 `.vipb` 的 `<Exclusions>`）。README 顶部保留 `[English](#…) | [中文](#…)` 语言导航，链接指向文中 `## English Description` / `## 中文描述` 两个语言分节，两种语言共用文件顶部唯一的 H1 标题。
- **单页版式**：wiki 的 QuickDrop 单页把 `Default Shortcut` 代码块放在页面最前面（结构：快捷键 → `-----` → 英文 → `-----` → 中文）；导航页 `_Sidebar.md`、`_Footer.md`、`Home.md` 不带中文。
