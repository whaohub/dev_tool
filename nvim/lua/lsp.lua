-- LSP 配置（Neovim 0.11+ 原生方式）
-- 语言服务器列表：:Mason 安装，vim.lsp.enable 启用

local servers = { "lua_ls", "clangd", "bashls", "pylsp" }

-- 1. 安装器
require("mason").setup({
  ui = { border = "rounded" },
})

require("mason-lspconfig").setup({
  -- 缺失的服务器会自动安装；已安装的会自动 enable
  ensure_installed = servers,
  automatic_enable = true,
})

-- 2. 全局默认（对所有服务器生效）：补全能力 + 诊断样式
vim.lsp.config("*", {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

vim.diagnostic.config({
  virtual_text = { spacing = 2, prefix = "●" },
  severity_sort = true,
  float = { border = "rounded", source = true },
  jump = { float = true },
})

-- 3. 各服务器专属设置
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
      hint = { enable = true },
    },
  },
})

-- clangd: 后台索引，编译参数从 compile_commands.json / .clangd 读取
--   cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .
vim.lsp.config("clangd", {
  cmd = { "clangd", "--background-index" },
})

-- 4. 启用
vim.lsp.enable(servers)

-- 5. 缓冲区内的按键（仅在 LSP 附加后生效）
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
  callback = function(ev)
    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
    end

    map("gd", vim.lsp.buf.definition, "Go to definition")
    map("gD", vim.lsp.buf.declaration, "Go to declaration")
    map("gi", vim.lsp.buf.implementation, "Go to implementation")
    map(",D", vim.lsp.buf.type_definition, "Go to type definition")
    map("K", vim.lsp.buf.hover, "Hover documentation")
    map("<C-k>", vim.lsp.buf.signature_help, "Signature help")
    map(",rn", vim.lsp.buf.rename, "Rename symbol")
    map(",ca", vim.lsp.buf.code_action, "Code action")
    map("gr", vim.lsp.buf.references, "References")
    map(",f", function()
      vim.lsp.buf.format({ async = true })
    end, "Format buffer")

    -- 只应用首选修复（quick fix）
    map("<leader>qf", function()
      vim.lsp.buf.code_action({
        filter = function(a)
          return a.isPreferred
        end,
        apply = true,
      })
    end, "Apply preferred code action")

    -- 工作区目录
    map(",wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
    map(",wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
    map(",wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "List workspace folders")

    -- inlay hints 开关
    local bufnr = ev.buf
    map("<leader>dh", function()
      local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
      vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
    end, "Toggle inlay hints")

    -- 诊断跳转
    map("[d", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, "Previous diagnostic")
    map("]d", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, "Next diagnostic")
    map(",e", vim.diagnostic.open_float, "Show diagnostic in float")
    map(",q", vim.diagnostic.setloclist, "Diagnostics to location list")
  end,
})

-- C/C++ 头文件与源文件切换
vim.keymap.set("n", "<leader>h", "<cmd>ClangdSwitchSourceHeader<cr>", { silent = true, desc = "Switch source/header" })
