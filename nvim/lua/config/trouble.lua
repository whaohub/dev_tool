local is_ok, trouble = pcall(require, "trouble")
if not is_ok then
  return
end

trouble.setup({
  auto_close = false,   -- auto close when there are no items
  auto_open = false,    -- auto open when there are items
  auto_preview = true,  -- automatically open preview when on an item
  auto_refresh = true,  -- auto refresh when open
  focus = false,        -- Focus the window when opened
  restore = true,       -- restores the last location in the list when opening
  follow = true,        -- Follow the current item
  indent_guides = true, -- show indent guides
  max_items = 200,      -- limit number of items that can be displayed per section
  multiline = true,     -- render multi-line messages
  pinned = false,       -- When pinned, the opened trouble window will be bound to the current buffer
  keys = {
    ["?"] = "help",
    r = "refresh",
    R = "toggle_refresh",
    q = "close",
    o = "jump_close",
    ["<esc>"] = "cancel",
    ["<cr>"] = "jump",
    ["<2-leftmouse>"] = "jump",
    ["<c-s>"] = "jump_split",
    ["<c-v>"] = "jump_vsplit",
    -- go down to next item (accepts count)
    -- j = "next",
    ["}"] = "next",
    ["]]"] = "next",
    -- go up to prev item (accepts count)
    -- k = "prev",
    ["{"] = "prev",
    ["[["] = "prev",
    i = "inspect",
    p = "preview",
    P = "toggle_preview",
    zo = "fold_open",
    zO = "fold_open_recursive",
    zc = "fold_close",
    zC = "fold_close_recursive",
    za = "fold_toggle",
    zA = "fold_toggle_recursive",
    zm = "fold_more",
    zM = "fold_close_all",
    zr = "fold_reduce",
    zR = "fold_open_all",
    zx = "fold_update",
    zX = "fold_update_all",
    zn = "fold_disable",
    zN = "fold_enable",
    zi = "fold_toggle_enable",

  },
  modes = {
    symbols = {
      desc = "Symbols",
      mode = "lsp_document_symbols", -- 使用 LSP 获取文档符号
      focus = false,                  -- 打开时不自动聚焦 Trouble 窗口
      win = { position = "right" },  -- Trouble 窗口显示在右侧
      filter = {
        -- 对于 Lua 文件，过滤掉 Package 类型（luals 用于控制流结构，通常不需要显示）
        ["not"] = { ft = "lua", kind = "Package" },
        any = {
          -- 对于 help/markdown 文件，显示所有符号类型
          ft = { "help", "markdown" },
          -- 默认显示的符号类型（可根据需要增删）
          kind = {
            "Class",       -- 类
            "Constructor", -- 构造函数
            "Enum",        -- 枚举
            "Field",       -- 字段
            "Function",    -- 函数
            "Interface",   -- 接口
            "Method",      -- 方法
            "Module",      -- 模块
            "Namespace",   -- 命名空间
            "Package",     -- 包
            "Property",    -- 属性
            "Struct",      -- 结构体
            "Trait",       -- 特性
          },
        },
      },
    },
  },
})
