-- 通用选项：VS Code 与独立 Neovim 都会加载这里
-- 提示：`:h <option>` 查看具体含义

local opt = vim.opt

-- 基础体验
opt.mouse = "a"
opt.clipboard = "unnamedplus" -- 与系统剪贴板共享
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.scrolloff = 4
opt.signcolumn = "yes" -- 常驻符号列，避免 gitsigns/诊断导致跳动
opt.termguicolors = true
opt.updatetime = 250
opt.timeoutlen = 400

-- 缩进
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

-- 搜索
opt.incsearch = true
opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true

-- 文件 / 编辑
opt.undofile = true -- 持久化撤销历史
opt.swapfile = false
opt.confirm = true

-- 复制时短暂高亮
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  desc = "highlight selection on yank",
  callback = function()
    vim.hl.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- 以下选项只在独立 Neovim 中生效（VS Code 的 UI 由 VS Code 负责）
if not vim.g.vscode then
  opt.splitbelow = true
  opt.splitright = true
  opt.showmode = false -- 已由 lualine 显示模式
  opt.completeopt = { "menu", "menuone", "noselect" }

  -- nvim-tree 需要禁用内置 netrw（必须在插件加载前设置）
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
end
