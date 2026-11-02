local is_ok, lualine = pcall(require, "lualine")
if not is_ok then
  return
end

lualine.setup({
  options = {
    theme = "gruvbox-material",
    icons_enabled = true,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    globalstatus = true, -- 所有窗口共用一个状态栏
    disabled_filetypes = { statusline = { "NvimTree", "Trouble", "lazy", "mason" } },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { { "filename", path = 1 } }, -- 相对路径即可
    lualine_x = { "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { { "filename", path = 1 } },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
})
