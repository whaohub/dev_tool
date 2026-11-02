-- 界面相关插件
return {
  -- 图标（被多个插件依赖）
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- 状态栏
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      require("config.lualine")
    end,
  },

  -- 顶部 buffer 标签栏
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      require("config.bufferline")
    end,
  },

  -- 缩进参考线
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("config.indent-blankline")
    end,
  },

  -- Git 装饰
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("config.gitsigns")
    end,
  },

  -- 文件树
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = {
      "NvimTreeToggle",
      "NvimTreeFocus",
      "NvimTreeOpen",
      "NvimTreeClose",
      "NvimTreeFindFile",
    },
    config = function()
      require("config.nvim-tree")
    end,
  },

  -- 诊断 / 符号列表
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("config.trouble")
    end,
  },
}
