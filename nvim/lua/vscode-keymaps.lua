-- VSCode specific keymaps
if vim.g.vscode then
    -- 使用 VSCode 的复制粘贴
    vim.keymap.set('v', '<C-c>', ':call VSCodeNotify("editor.action.clipboardCopyAction")<CR>', { silent = true })
    vim.keymap.set('n', '<C-v>', '"+p', { silent = true })
   vim.keymap.set('i', '<C-v>', '<C-r>+', { silent = true })
       
    -- 如果想用 VSCode 的保存等功能
    vim.keymap.set('n', '<C-s>', ':call VSCodeCall("workbench.action.files.save")<CR>', { silent = true })
    
    -- 如果想用 VSCode 的撤销重做
    vim.keymap.set('n', '<C-z>', ':call VSCodeCall("undo")<CR>', { silent = true })
     -- Comment toggles
    vim.keymap.set('n', 'gc', "<Cmd>call VSCodeNotify('editor.action.commentLine')<CR>", { silent = true })
    vim.keymap.set('n', 'gC', "<Cmd>call VSCodeNotify('editor.action.blockComment')<CR>", { silent = true })

    -- Folding
    vim.keymap.set('n', 'zR', "<Cmd>call VSCodeNotify('editor.unfoldAll')<CR>", { silent = true })
    vim.keymap.set('n', 'zM', "<Cmd>call VSCodeNotify('editor.foldAll')<CR>", { silent = true })
    vim.keymap.set('n', 'zo', "<Cmd>call VSCodeNotify('editor.unfold')<CR>", { silent = true })
    vim.keymap.set('n', 'zc', "<Cmd>call VSCodeNotify('editor.fold')<CR>", { silent = true })
    vim.keymap.set('n', 'zz', "<Cmd>call VSCodeNotify('editor.toggleFold')<CR>", { silent = true })

    -- Diagnostics navigation
    vim.keymap.set('n', 'g[', "<Cmd>call VSCodeNotify('editor.action.marker.prevInFiles')<CR>", { silent = true })
    vim.keymap.set('n', 'g]', "<Cmd>call VSCodeNotify('editor.action.marker.nextInFiles')<CR>", { silent = true })

    -- Replace H and L
    vim.keymap.set('n', 'H', '^', { noremap = true, silent = true })
    vim.keymap.set('n', 'L', '$', { noremap = true, silent = true }) 
    vim.keymap.set('n', '<C-y>', ':call VSCodeCall("redo")<CR>', { silent = true })
end
