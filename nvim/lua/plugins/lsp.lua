-- LSP：Neovim 0.11 内置客户端（vim.lsp.config / vim.lsp.enable）
-- mason 负责安装语言服务器本体，nvim-lspconfig 只提供服务器默认配置
-- 三者的 setup 统一放在 lua/lsp.lua 中，避免初始化顺序问题
return {
  { "williamboman/mason.nvim", lazy = false },

  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = { "williamboman/mason.nvim" },
  },

  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("lsp")
    end,
  },
}
