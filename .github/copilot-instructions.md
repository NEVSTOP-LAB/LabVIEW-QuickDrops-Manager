# Copilot Instructions

## 目录结构/版本管理

- **临时文件目录**：生成的临时文件放在 `.tmp/` 目录下, 不提交到版本控制系统
- **Wiki 目录**：`.wiki/` 是 GitHub Wiki 仓库（`NEVSTOP-LAB/LabVIEW-QuickDrops-Manager.wiki.git`）的 submodule，wiki 文档的修改在该目录内提交并推送
- **pr留言**：每完成一个阶段（一批提交）后，用 `gh pr status` 检查当前分支是否有关联的 open PR；若有关联，用 `gh pr comment` 留言本阶段修改的背景、内容与关键决策，并用 `gh pr edit --body-file` 总结 PR 修改描述
- **issue创建**：创建issue时，添加适当的标签以便分类和跟踪; 复杂问题中，需要有checkbox列表跟踪任务完成情况
- **issue留言**：如果上下文了解到是在处理issue，每完成一个阶段，在 issue 中留言相关的背景、内容与关键决策
- **修改前同步认知**：在进行修改前，确认是否完全理解需求，如果不清楚，采访用户直到理解全部的细节