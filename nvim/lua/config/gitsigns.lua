local is_ok, gitsigns = pcall(require, "gitsigns")
if not is_ok then
  return
end

gitsigns.setup({
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
  },
  current_line_blame = false,
  current_line_blame_opts = { virt_text = true, virt_text_pos = "eol", delay = 1000 },
  preview_config = { border = "rounded", style = "minimal", relative = "cursor", row = 0, col = 1 },
  on_attach = function(bufnr)
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = "Git: " .. desc })
    end
    map("n", "]c", gitsigns.next_hunk, "Next hunk")
    map("n", "[c", gitsigns.prev_hunk, "Previous hunk")
    map("n", "<leader>gp", gitsigns.preview_hunk, "Preview hunk")
    map("n", "<leader>gb", function() gitsigns.blame_line({ full = true }) end, "Blame line")
    map("n", "<leader>gr", gitsigns.reset_hunk, "Reset hunk")
    map("n", "<leader>gs", gitsigns.stage_hunk, "Stage hunk")
  end,
})
