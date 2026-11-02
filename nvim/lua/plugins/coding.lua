-- 编辑增强：补全、片段、自动配对、语法高亮
return {
  -- 片段引擎（配合 friendly-snippets 提供开箱即用的片段）
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  -- 补全引擎
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP 补全
      "hrsh7th/cmp-buffer", -- 缓冲区补全
      "hrsh7th/cmp-path", -- 路径补全
      "hrsh7th/cmp-cmdline", -- 命令行补全
      "saadparwaiz1/cmp_luasnip", -- 片段补全
      "L3MON4D3/LuaSnip",
      "onsails/lspkind.nvim", -- 补全菜单图标
      "windwp/nvim-autopairs", -- 确认补全后自动补全括号
    },
    config = function()
      require("config.nvim-cmp")
    end,
  },

  -- 自动配对括号/引号
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("config.nvim-autopairs")
    end,
  },

  -- 语法高亮（高亮由 Neovim 内置实现，插件只提供 parser 与查询）
  {
    "nvim-treesitter/nvim-treesitter",
    -- master 是官方冻结分支，兼容 Nvim 0.11；main 分支需要 Nvim 0.12+
    branch = "master",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      require("config.nvim-treesitter")
    end,
  },
}
