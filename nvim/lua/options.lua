-- Common options (both VSCode and Neovim)
-- Hint: use `:h <option>` to figure out the meaning if needed
vim.opt.clipboard = 'unnamedplus' -- use system clipboard
vim.opt.mouse = 'a' -- allow the mouse to be used in Nvim

-- Tab
vim.opt.tabstop = 2 -- number of visual spaces per TAB
vim.opt.softtabstop = 2 -- number of spacesin tab when editing
vim.opt.shiftwidth = 2 -- insert 2 spaces on a tab
vim.opt.expandtab = true -- tabs are spaces, mainly because of python

-- Searching (common for both)
vim.opt.incsearch = true -- search as characters are entered
vim.opt.hlsearch = false -- do not highlight matches
vim.opt.ignorecase = true -- ignore case in searches by default
vim.opt.smartcase = true -- but make it case sensitive if an uppercase is entered
vim.opt.number = true -- show absolute number
vim.opt.relativenumber = true -- add numbers to each line on the left side
vim.opt.foldopen = { "search" }

-- 仅在普通 neovim 环境中加载的选项
if not vim.g.vscode then
    -- ui config
    vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
    vim.opt.cursorline = true -- highlight cursor line underneath the cursor horizontally
    vim.opt.splitbelow = true -- open new vertical split bottom
    vim.opt.splitright = true -- open new horizontal splits right
    vim.opt.showmode = false -- we are experienced, wo don't need the "-- insert --" mode hint

    -- for nvim-tree
    -- disable netrw at the very start of your init.lua (strongly advised)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwplugin = 1
end

vim.api.nvim_create_autocmd('textyankpost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 500 }
  end,
})
