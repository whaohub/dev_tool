-- Load common options for both VSCode and vanilla Neovim
require("options")

if vim.g.vscode then
  require("vscode-keymaps")
  -- Only loaded when embedded in VS Code
else
  -- Standard standalone Neovim
  require("keymaps")
  require("plugins")
  require("colorscheme")
  require("lsp")
end