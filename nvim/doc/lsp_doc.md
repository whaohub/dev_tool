# LSP 使用说明

本文件根据 `lua/lsp.lua` 自动生成，包含 LSP 配置方法及相关快捷键说明。

---

## 基本使用

1. 安装 LSP 插件（推荐使用 Mason）：
   - `:Mason` 命令打开插件管理界面，安装所需语言服务器。
2. 自动安装的服务器示例：`clangd`, `lua_ls`。
3. 按需添加语言服务器配置，例如：
   ```lua
   lspconfig.<name>.setup({
     on_attach = on_attach,
     -- 其他配置项
   })
   ```
   其中 `<name>` 可参考 [官方文档](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)。

## 常用 LSP 快捷键

| 模式   | 快捷键         | 功能描述                   |
|--------|----------------|----------------------------|
| 普通   | ,e             | 显示诊断信息浮窗           |
| 普通   | [d             | 跳转到上一个诊断           |
| 普通   | ]d             | 跳转到下一个诊断           |
| 普通   | ,q             | 打开诊断列表               |
| 普通   | <Leader>qf     | 快速修复（首选 code action）|
| 普通   | gD             | 跳转到声明                 |
| 普通   | gd             | 跳转到定义                 |
| 普通   | K              | 显示悬停文档               |
| 普通   | gi             | 跳转到实现                 |
| 普通   | <C-k>          | 显示签名帮助               |
| 普通   | ,wa            | 添加工作区文件夹           |
| 普通   | ,wr            | 移除工作区文件夹           |
| 普通   | <Leader>dh     | 切换 inlay hints           |
| 普通   | ,wl            | 列出工作区文件夹           |
| 普通   | ,D             | 跳转到类型定义             |
| 普通   | ,rn            | 重命名                     |
| 普通   | ,ca            | 代码操作                   |
| 普通   | gr             | 查找引用                   |
| 普通   | ,f             | 格式化代码                 |

## 语言服务器配置示例

- **Python**
  ```lua
  lspconfig.pylsp.setup({
    on_attach = on_attach,
  })
  ```
- **Lua**
  ```lua
  lspconfig.lua_ls.setup({
    on_attach = on_attach,
    settings = { ... }
  })
  ```
- **C/C++ (Clangd)**
  ```lua
  lspconfig.clangd.setup({
    on_attach = on_attach,
    filetypes = { "h", "c", "cpp", "cc", "objc", "objcpp" },
    cmd = { "clangd", "--background-index" },
    single_file_support = true,
    root_dir = lspconfig.util.root_pattern(
      '.clangd', '.clang-tidy', '.clang-format',
      'compile_commands.json', 'compile_flags.txt',
      'configure.ac', '.git'
    ),
  })
  ```

---

更多配置请参考 [nvim-lspconfig 官方文档](https://github.com/neovim/nvim-lspconfig).
