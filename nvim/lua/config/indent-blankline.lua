local is_ok, indent_blankline = pcall(require, "ibl")
if not is_ok then
  return
end

-- For all available options, take a look at `:help ibl.config.`
indent_blankline.setup {
  indent = { char = "|" }, -- 缩进线符号
  scope = {
    show_start = true,
    show_end = true,
    char = "┆", -- 折叠/范围线符号，注意不是 symbol
  },
}
