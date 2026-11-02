-- 主题（启动即加载，priority 保证在其他插件之前）
return {
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      require("colorscheme")
    end,
  },
}
