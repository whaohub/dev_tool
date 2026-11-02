-- lazy.nvim 引导：插件清单按用途拆分在 lua/plugins/*.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = { import = "plugins" },
  install = { colorscheme = { "gruvbox-material", "habamax" } },
  checker = { enabled = false }, -- 不自动检查更新，需要时 :Lazy update
  change_detection = { notify = false },
})
