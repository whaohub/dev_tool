-- VS Code 专用按键（仅在 vscode-neovim 扩展下加载，不加载任何插件）
-- 作用：把 VSCode 的原生命令接到 vim 键位上，保持 VSCode 原生体验
local map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

-- 剪贴板：交给 VSCode 处理
map("v", "<C-c>", ':call VSCodeNotify("editor.action.clipboardCopyAction")<CR>', "Copy")
map("n", "<C-v>", '"+p', "Paste")
map("i", "<C-v>", "<C-r>+", "Paste")

-- 保存 / 撤销 / 重做
map("n", "<C-s>", ':call VSCodeCall("workbench.action.files.save")<CR>', "Save")
map("n", "<C-z>", ':call VSCodeCall("undo")<CR>', "Undo")
map("n", "<C-y>", ':call VSCodeCall("redo")<CR>', "Redo")

-- 注释
map("n", "gc", "<Cmd>call VSCodeNotify('editor.action.commentLine')<CR>", "Toggle line comment")
map("n", "gC", "<Cmd>call VSCodeNotify('editor.action.blockComment')<CR>", "Toggle block comment")

-- 折叠
map("n", "zR", "<Cmd>call VSCodeNotify('editor.unfoldAll')<CR>", "Unfold all")
map("n", "zM", "<Cmd>call VSCodeNotify('editor.foldAll')<CR>", "Fold all")
map("n", "zo", "<Cmd>call VSCodeNotify('editor.unfold')<CR>", "Unfold")
map("n", "zc", "<Cmd>call VSCodeNotify('editor.fold')<CR>", "Fold")
map("n", "zz", "<Cmd>call VSCodeNotify('editor.toggleFold')<CR>", "Toggle fold")

-- 诊断跳转
map("n", "g[", "<Cmd>call VSCodeNotify('editor.action.marker.prevInFiles')<CR>", "Previous problem")
map("n", "g]", "<Cmd>call VSCodeNotify('editor.action.marker.nextInFiles')<CR>", "Next problem")

-- H / L 改为行首 / 行尾
map("n", "H", "^", "Line start")
map("n", "L", "$", "Line end")
