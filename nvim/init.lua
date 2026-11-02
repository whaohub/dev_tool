-- Neovim 入口
-- 说明：本配置同时被「独立 Neovim」与「VS Code + vscode-neovim 扩展」使用。
--   * vim.g.vscode 为真  -> 只加载通用选项 + VS Code 专用按键（不加载任何插件）
--   * 独立 Neovim        -> 加载完整插件生态

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("options")

if vim.g.vscode then
  require("vscode-keymaps")
else
  require("keymaps")
  require("config.lazy") -- lazy.nvim 引导，插件清单见 lua/plugins/
end
