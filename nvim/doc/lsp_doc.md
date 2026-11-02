# LSP 使用说明

配置在 `lua/lsp.lua`，使用 Neovim 0.11 原生方式（`vim.lsp.config` + `vim.lsp.enable`），
语言服务器本体由 [mason](https://github.com/williamboman/mason.nvim) 安装。

## 已启用

| 服务器 | 语言 |
|--------|------|
| `lua_ls` | Lua |
| `clangd` | C / C++ |
| `bashls` | Shell |
| `pylsp` | Python |

## 日常操作

- `:Mason` 安装 / 更新 / 卸载语言服务器
- `:checkhealth vim.lsp` 查看 LSP 状态
- `:LspInfo`（nvim-lspconfig）查看已附加的客户端

## 添加新的语言服务器

1. `:Mason` 里安装对应的 server（或在 `ensure_installed` 列表中加入并重启）。
2. 编辑 `lua/lsp.lua`：

```lua
local servers = { "lua_ls", "clangd", "bashls", "pylsp", "gopls" } -- 加进来

-- 需要专属设置时（可选）
vim.lsp.config("gopls", {
  settings = { gopls = { usePlaceholders = true } },
})

vim.lsp.enable(servers)
```

`vim.lsp.config("*", ...)` 里的设置（补全能力等）会自动合并到所有服务器。

## C/C++ 说明

`clangd` 启动参数为 `--background-index`，编译参数来源（任选其一）：

- `compile_commands.json`：`cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .`
- 项目根目录的 `compile_flags.txt`（每行一个编译参数）
- `.clangd` 配置文件

## 快捷键（仅在 LSP 附加到缓冲区后生效）

| 快捷键 | 功能 |
|--------|------|
| `gd` / `gD` | 跳转定义 / 声明 |
| `gi` / `,D` | 跳转实现 / 类型定义 |
| `K` | 悬停文档 |
| `Ctrl+k` | 函数签名 |
| `gr` | 引用列表 |
| `,rn` | 重命名 |
| `,ca` | 代码操作 |
| `<Leader>qf` | 应用首选修复 |
| `,f` | 格式化 |
| `[d` / `]d` | 上 / 下一条诊断 |
| `,e` / `,q` | 诊断浮窗 / 写入 location list |
| `<Leader>dh` | 切换 inlay hints |
| `,wa` / `,wr` / `,wl` | 添加 / 移除 / 列出 workspace 目录 |

更多信息：`:help lsp`、`:help lspconfig-all`。
