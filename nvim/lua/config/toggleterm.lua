local is_ok, toggleterm = pcall(require, "toggleterm")
if not is_ok then
  return
end

toggleterm.setup({
  size = 20,
  open_mapping = [[<C-_>]],
  hide_numbers = true,
  close_on_exit = true,
  shell = vim.o.shell,
  direction = "float",
  shading_factor = 2,
  float_opts = { border = "curved" },
})

-- 终端模式下的按键：快速回到普通模式并在窗口间移动
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("TerminalKeymaps", { clear = true }),
  pattern = "term://*",
  callback = function(ev)
    local opts = { buffer = ev.buf, noremap = true, silent = true }
    vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
    vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
    vim.keymap.set("t", "<C-h>", [[<cmd>wincmd h<cr>]], opts)
    vim.keymap.set("t", "<C-j>", [[<cmd>wincmd j<cr>]], opts)
    vim.keymap.set("t", "<C-k>", [[<cmd>wincmd k<cr>]], opts)
    vim.keymap.set("t", "<C-l>", [[<cmd>wincmd l<cr>]], opts)
  end,
})
