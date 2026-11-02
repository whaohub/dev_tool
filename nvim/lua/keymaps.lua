-- 全局按键映射（仅独立 Neovim）
-- 缓冲区内的 LSP 映射见 lua/lsp.lua，文件树内部映射见 lua/config/nvim-tree.lua

local map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

-- 保存 / 退出
map("n", "<leader>w", "<cmd>write<cr>", "Save file")
map("n", "<leader>q", "<cmd>quit<cr>", "Quit window")
map("n", "<leader>Q", "<cmd>quitall<cr>", "Quit all")
map("i", "jj", "<esc>", "Exit insert mode")

-- 窗口导航
map("n", "<C-h>", "<C-w>h", "Go to left window")
map("n", "<C-j>", "<C-w>j", "Go to lower window")
map("n", "<C-k>", "<C-w>k", "Go to upper window")
map("n", "<C-l>", "<C-w>l", "Go to right window")

-- 窗口缩放
map("n", "<C-Up>", "<cmd>resize -2<cr>", "Shrink height")
map("n", "<C-Down>", "<cmd>resize +2<cr>", "Grow height")
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", "Shrink width")
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", "Grow width")

-- 缩进后保持选区
map("v", "<", "<gv", "Indent left")
map("v", ">", ">gv", "Indent right")

-- 文件树
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", "Toggle file tree")

-- 缓冲区（bufferline）
map("n", "gT", "<cmd>BufferLineCyclePrev<cr>", "Previous buffer")
map("n", "gt", "<cmd>BufferLineCycleNext<cr>", "Next buffer")
map("n", "<leader>bc", "<cmd>bdelete<cr>", "Close buffer")
map("n", "<leader>bp", "<cmd>BufferLinePickClose<cr>", "Pick buffer to close")
map("n", "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", "Close other buffers")
for i = 1, 9 do
  map("n", "<leader>" .. i, ("<cmd>BufferLineGoToBuffer %d<cr>"):format(i), "Buffer " .. i)
end

-- 模糊查找（telescope，按需加载）
local function pick(lhs, builtin, desc)
  vim.keymap.set("n", lhs, function()
    require("telescope.builtin")[builtin]()
  end, { silent = true, desc = desc })
end
pick("<leader>ff", "find_files", "Find files")
pick("<leader>fg", "git_files", "Find git files")
pick("<leader>fo", "oldfiles", "Recent files")
pick("<leader>fb", "buffers", "Buffers")
pick("<leader>fl", "live_grep", "Live grep")
pick("<leader>fc", "grep_string", "Grep word under cursor")
pick("<leader>fd", "diagnostics", "Diagnostics")
pick("<leader>fh", "help_tags", "Help tags")

-- Trouble（诊断/符号列表）
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", "Diagnostics (Trouble)")
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", "Buffer diagnostics")
map("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", "Symbols (Trouble)")
map("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", "LSP references")
map("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", "Location list")
map("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", "Quickfix list")
