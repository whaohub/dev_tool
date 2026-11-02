-- 工具类插件
return {
  -- 模糊查找
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    config = function()
      require("config.telescope")
    end,
  },

  -- 浮动终端（setup 里注册了打开终端的快捷键，故延迟到启动完成后加载）
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("config.toggleterm")
    end,
  },

  -- Git 命令
  { "tpope/vim-fugitive", cmd = { "Git", "G" } },
}
