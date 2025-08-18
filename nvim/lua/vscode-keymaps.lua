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
    vim.keymap.set('n', '<C-y>', ':call VSCodeCall("redo")<CR>', { silent = true })
end
