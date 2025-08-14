# Telescope.nvim 使用说明及快捷键文档

本文件根据 `lua/config/telescope.lua` 自动生成，便于查阅和自定义。

---

## 基本使用

Telescope 是 Neovim 的模糊查找插件，支持文件、缓冲区、Git、文本等多种查找方式。

### 常用命令
- `:Telescope` 打开主界面
- `:Telescope find_files` 查找文件
- `:Telescope live_grep` 全局文本搜索
- `:Telescope buffers` 查找缓冲区
- `:Telescope git_files` 查找 Git 管理的文件

## 快捷键说明

| 模式   | 快捷键         | 功能描述                   |
|--------|----------------|----------------------------|
| 普通   | <Leader>ff     | 查找文件                   |
| 普通   | <Leader>fg     | 查找 Git 文件              |
| 普通   | <Leader>fo     | 查找最近打开文件           |
| 普通   | <Leader>fb     | 查找缓冲区                 |
| 普通   | <Leader>fl     | 全局文本搜索（live grep）   |
| 普通   | <Leader>fc     | 查找当前字符串              |

## 插件内快捷键（Telescope 界面）

| 模式   | 快捷键         | 功能描述                   |
|--------|----------------|----------------------------|
| 插入   | <C-n>          | 下一个历史项               |
| 插入   | <C-p>          | 上一个历史项               |
| 插入/普通 | <C-j>        | 下移选中项                 |
| 插入/普通 | <C-k>        | 上移选中项                 |

---

如需更多自定义或扩展功能，请参考 [Telescope 官方文档](https://github.com/nvim-telescope/telescope.nvim) 或补充本文件。
