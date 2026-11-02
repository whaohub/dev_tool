local is_ok, indent_blankline = pcall(require, "ibl")
if not is_ok then
  return
end

indent_blankline.setup({
  indent = { char = "│" },
  scope = { enabled = true, show_start = false, show_end = false },
  exclude = { filetypes = { "help", "dashboard", "NvimTree", "lazy", "mason", "Trouble" } },
})
