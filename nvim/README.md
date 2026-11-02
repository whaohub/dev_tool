# Neovim 配置

个人 Neovim 配置（macOS），基于 Neovim 0.11 + [lazy.nvim](https://github.com/folke/lazy.nvim)。
同一份配置同时服务 **独立 Neovim** 与 **VS Code（vscode-neovim 扩展）**。

## 目录结构

```
init.lua                 -- 入口：设置 leader → options → 分叉（vscode / 独立）
lua/
├── options.lua          -- 两边共用的编辑器选项
├── keymaps.lua          -- 独立 Neovim 的全局按键（保存/窗口/telescope/trouble/bufferline）
├── vscode-keymaps.lua   -- 仅 VS Code：把 VSCode 原生命令接到 vim 键位
├── config/
│   └── lazy.lua         -- lazy.nvim 引导（插件清单在 lua/plugins/）
├── plugins/             -- 插件清单，按用途拆分
│   ├── colorscheme.lua  -- gruvbox-material
│   ├── ui.lua           -- lualine / bufferline / nvim-tree / ibl / gitsigns / trouble
│   ├── coding.lua       -- nvim-cmp / LuaSnip / autopairs / treesitter
│   ├── lsp.lua          -- mason / mason-lspconfig / nvim-lspconfig
│   └── tools.lua        -- telescope / toggleterm / fugitive
├── lsp.lua              -- LSP 配置（vim.lsp.config / vim.lsp.enable）
├── colorscheme.lua      -- 主题变量 + :colorscheme
└── config/*.lua         -- 各插件的 setup 细节
```

## 与 VS Code 的关系

`vim.g.vscode` 为真时（vscode-neovim 扩展）：

- 只加载 `options.lua` + `vscode-keymaps.lua`
- **不加载**任何插件、颜色主题、LSP —— VS Code 自己负责这些
- 复制粘贴、保存、撤销、注释、折叠、诊断跳转都走 VS Code 原生命令

验证方式：

```bash
nvim --headless --cmd 'let g:vscode=1' +qa     # 应无报错、不加载 lazy
```

## 常用操作

| 命令 | 说明 |
|------|------|
| `:Lazy` | 插件管理（`sync` / `update` / `restore`） |
| `:Mason` | 语言服务器安装与管理 |
| `:TSUpdate` | 更新 treesitter 解析器 |
| `:checkhealth` | 健康检查 |

## 版本说明

- 主题、LSP、补全、telescope、trouble、nvim-tree：见 `doc/`
- `nvim-treesitter` 锁定 `master` 分支（官方冻结分支，兼容 Nvim 0.11）。
  升级到 Nvim 0.12+ 后可改为 `branch = "main"`，并使用内置 `vim.treesitter.start()`。
- `nvim-lspconfig` 已使用 0.11 的 `vim.lsp.config` / `vim.lsp.enable`（旧的 `require("lspconfig").X.setup()` 已弃用）。

文档：[按键](doc/keymaps_doc.md) · [LSP](doc/lsp_doc.md) · [Telescope](doc/telescope_doc.md) · [Trouble](doc/trouble_keymaps.md)
