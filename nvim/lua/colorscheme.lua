-- define your colorscheme here
local colorscheme = 'gruvbox'

-- Enable 24-bit RGB color in the TUI
if vim.fn.empty(vim.fn.getenv("TMUX")) == 1 and vim.fn.getenv("TERM_PROGRAM") ~= "Apple_Terminal" then
    -- For Neovim > 0.1.5 and Vim > patch 7.4.1799
    if vim.fn.has("termguicolors") == 1 then
        vim.opt.termguicolors = true
    end
    -- For Neovim 0.1.3 and 0.1.4
    vim.fn.setenv("NVIM_TUI_ENABLE_TRUE_COLOR", 1)
end

local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not is_ok then
    vim.notify('colorscheme ' .. colorscheme .. ' not found!')
    return
end
vim.g.gruvbox_contrast_dark = 'medium'
vim.g.gruvbox_invert_selection = '0' -- Disable inverted selection

-- Enable the Gruvbox colorscheme
vim.cmd([[colorscheme gruvbox]])
