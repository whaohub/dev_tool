-- define your colorscheme here
local colorscheme = 'gruvbox-material'

local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not is_ok then
  vim.notify('colorscheme ' .. colorscheme .. ' not found!')
  return
end

vim.g.gruvbox_material_foreground = "original"
-- Enable the Gruvbox colorscheme
vim.cmd([[colorscheme gruvbox-material]])
