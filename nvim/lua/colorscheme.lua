-- 主题设置（变量必须在 :colorscheme 之前设置）
vim.o.background = "dark"
vim.g.gruvbox_material_background = "medium"
vim.g.gruvbox_material_foreground = "original"
vim.g.gruvbox_material_better_performance = 1

local ok = pcall(vim.cmd.colorscheme, "gruvbox-material")
if not ok then
  vim.notify("colorscheme gruvbox-material not found!", vim.log.levels.WARN)
end
