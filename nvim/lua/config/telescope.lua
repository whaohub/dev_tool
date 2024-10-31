local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
    return
end

local actions = require('telescope.actions')

-- Telescope setup with custom mappings
telescope.setup {
  defaults = {
    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
      },
    },
  },
}

local is_ok, builtin = pcall(require, "telescope.builtin")
if not is_ok then
	return
end

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {}) -- i.e. previously open files
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fl', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fc', builtin.grep_string, {})

-- vim.keymap.set("n", "<leader>fc", function() -- fc = find by command
-- 	builtin.grep_string({ search = vim.fn.input("Grep > ") })
-- end)
