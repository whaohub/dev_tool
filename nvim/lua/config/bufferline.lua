-- lua/config/bufferline.lua
require("bufferline").setup {
  options = {
    mode = "buffers",            -- show buffers (other option: "tabs")
    numbers = "ordinal",         -- show buffer numbers
    diagnostics = "nvim_lsp",    -- show LSP diagnostics
    separator_style = "slant",   -- tab separator style: "slant", "thick", "thin"
    show_buffer_close_icons = true,
    show_close_icon = false,
    always_show_bufferline = true,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        separator = true,
      },
    },
  },
}

local opts = { noremap = true, silent = true }

-- Cycle through buffers
vim.keymap.set("n", "gt", "<cmd>BufferLineCycleNext<CR>", opts)
vim.keymap.set("n", "gT", "<cmd>BufferLineCyclePrev<CR>", opts)

-- Jump to buffers 1-9
for i = 1, 9 do
  vim.keymap.set("n", "<leader>" .. i,
    string.format("<cmd>BufferLineGoToBuffer %d<CR>", i),
    opts
  )
end

-- Close buffers efficiently
vim.keymap.set("n", "<leader>bc", ":bdelete %<CR>", opts)               -- close current
vim.keymap.set("n", "<leader>bp", "<cmd>BufferLinePickClose<CR>", opts) -- pick and close
vim.keymap.set("n", "<leader>bo", "<cmd>BufferLineCloseLeft<CR><cmd>BufferLineCloseRight<CR>", opts) -- close all but current:contentReference[oaicite:1]{index=1}
