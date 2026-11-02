local is_ok, nvim_tree = pcall(require, "nvim-tree")
if not is_ok then
  return
end

-- 文件树内部按键：默认映射由插件提供，这里只补充/覆盖少量常用项
-- 默认键位速查：<CR> 打开, a 新建, d 删除, r 重命名, g? 帮助
local function on_attach(bufnr)
  local api = require("nvim-tree.api")
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set("n", "u", api.tree.change_root_to_parent, opts("Up"))
  vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close directory"))
  vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: vertical split"))
  vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
end

nvim_tree.setup({
  on_attach = on_attach,
  sort_by = "case_sensitive",
  git = { enable = true, ignore = false }, -- 显示被 git 忽略的文件
  filters = { git_ignored = false, dotfiles = true },
  renderer = {
    group_empty = true,
    indent_markers = { enable = true },
  },
  diagnostics = { enable = true },
  update_focused_file = { enable = true, update_cwd = false },
})
