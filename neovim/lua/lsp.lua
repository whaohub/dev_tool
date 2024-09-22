-- Note: The order matters: require("mason") -> require("mason-lspconfig") -> require("lspconfig")

require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

require("mason-lspconfig").setup({
  -- A list of servers to automatically install if they're not already installed.
  ensure_installed = { "clangd", "lua_ls" },
})

-- Set different settings for different languages' LSP.
-- LSP list: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- How to use setup({}): https://github.com/neovim/nvim-lspconfig/wiki/Understanding-setup-%7B%7D
--     - the settings table is sent to the LSP.
--     - on_attach: a lua callback function to run after LSP attaches to a given buffer.
local lspconfig = require("lspconfig")

-- Customized on_attach function.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions.
local opts = { noremap = true, silent = true }
vim.keymap.set("n", ",e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", ",q", vim.diagnostic.setloclist, opts)

local function quickfix()
    vim.lsp.buf.code_action({
        filter = function(a) return a.isPreferred end,
        apply = true
    })
end
vim.keymap.set('n', '<leader>qf', quickfix, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer.
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  -- WARNING: This feature requires Neovim 0.10 or later.
  vim.lsp.inlay_hint.enable(true)
  vim.g.inlay_hints_visible = false
 local function toggle_inlay_hints()
    if vim.g.inlay_hints_visible then
      vim.g.inlay_hints_visible = false
      vim.lsp.inlay_hint.enable(true)
    else
      if client.server_capabilities.inlayHintProvider then
        vim.g.inlay_hints_visible = true
        vim.lsp.inlay_hint.enable(true)
      else
        print("no inlay hints available")
      end
    end
  end

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", ",wa", vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set("n", ",wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set(
    "n",
    "<leader>dh",
    toggle_inlay_hints,
    vim.tbl_extend("force", bufopts, { desc = "✨lsp toggle inlay hints" })
  )
  vim.keymap.set("n", ",wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set("n", ",D", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", ",rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", ",ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', ',f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- How to add a LSP for a specific programming language?
-- 1. Use `:Mason` to install the corresponding LSP.
-- 2. Add the configuration below. The syntax is `lspconfig.<name>.setup(...)`
-- Hint (find <name> here) : https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
lspconfig.pylsp.setup({
  on_attach = on_attach,
})

lspconfig.lua_ls.setup({
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim).
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global.
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files.
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier.
      telemetry = {
        enable = false,
      },
      hint = { true },
    },
  },
})

lspconfig.bashls.setup({})

lspconfig.clangd.setup({
  on_attach = on_attach,
  filetypes = { "h", "c", "cpp", "cc", "objc", "objcpp" },
  cmd = { "clangd", "--background-index" },
  single_file_support = true,
  root_dir = lspconfig.util.root_pattern(
    '.clangd',
    '.clang-tidy',
    '.clang-format',
    'compile_commands.json',
    'compile_flags.txt',
    'configure.ac',
    '.git'
  ),
})

-- Case 1. For CMake User
--     $ cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .
-- Case 2. For Bazel User, use https://github.com/hedronvision/bazel-compile-commands-extractor
-- Case 3. If you don't use any build tool and all files in a project use the same build flags
--     Place your compiler flags in the compile_flags.txt file, located in the root directory
--     of your project. Each line in the file should contain a single compiler flag.
-- src: https://clangd.llvm.org/installation#compile_commandsjson
lspconfig.clangd.setup({
  on_attach = on_attach,
})
