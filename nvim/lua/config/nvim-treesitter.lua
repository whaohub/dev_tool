local is_ok, configs = pcall(require, "nvim-treesitter.configs")
if not is_ok then
  return
end

configs.setup({
  -- 需要安装高亮的语言（:TSInstall / :TSUpdate 手动维护，缺失时自动补装）
  ensure_installed = {
    "c",
    "cpp",
    "lua",
    "vim",
    "vimdoc",
    "query",
    "python",
    "bash",
    "json",
    "yaml",
    "toml",
    "make",
    "cmake",
    "markdown",
    "markdown_inline",
    "dockerfile",
    "gitcommit",
    "gitignore",
    "diff",
  },
  auto_install = true,
  sync_install = false,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },

  -- gss 开始选择，gsi/gsc 扩大，gsd 缩小
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gss",
      node_incremental = "gsi",
      scope_incremental = "gsc",
      node_decremental = "gsd",
    },
  },
})

-- 用 treesitter 计算折叠（默认不折叠）
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TSFold", { clear = true }),
  callback = function()
    if pcall(vim.treesitter.get_parser, 0) then
      vim.opt_local.foldmethod = "expr"
      vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt_local.foldenable = false
    end
  end,
})
