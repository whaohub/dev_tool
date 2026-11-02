local is_ok, npairs = pcall(require, "nvim-autopairs")
if not is_ok then
  return
end

npairs.setup({
  disable_filetype = { "TelescopePrompt" },
  map_cr = true,
  check_ts = true,
  ts_config = {
    lua = { "string" },
    javascript = { "template_string" },
    java = false,
  },
})
