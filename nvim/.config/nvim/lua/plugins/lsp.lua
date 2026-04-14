-- Rounded borders for all floating windows (LSP hover/signature, lazy
-- prompts, etc.). Replaces the per-handler vim.lsp.with overrides from the
-- old config.
vim.o.winborder = "rounded"

-- Default capabilities for every server: nvim's defaults extended with
-- blink.cmp's (snippets, completion item resolve, etc.). Per-server
-- vim.lsp.config calls below merge on top of this.
vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})

-- Per-server overrides. Defaults come from nvim-lspconfig's lsp/<name>.lua
-- files on the runtimepath; vim.lsp.config layers our settings on top.
vim.lsp.config("clojure_lsp", {})
vim.lsp.config("bashls", {})
vim.lsp.config("sqlls", {})
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
    },
  },
})

vim.lsp.config("markdown_oxide", {})

vim.lsp.enable({ "clojure_lsp", "bashls", "sqlls", "lua_ls", "markdown_oxide" })

-- Diagnostic display.
vim.diagnostic.config({
  virtual_text    = false,
  severity_sort   = true,
  underline       = true,
  update_in_insert = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN]  = "",
      [vim.diagnostic.severity.INFO]  = "",
      [vim.diagnostic.severity.HINT]  = "",
    },
  },
})

-- Global diagnostic key. ([d / ]d are nvim 0.11+ defaults using
-- vim.diagnostic.jump under the hood.)
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show diagnostic float" })

-- Buffer-local LSP keymaps. nvim 0.11+ ships defaults for K, grn, gra,
-- grr, gri, gO, and <C-S> in insert mode — see CHANGES.md for old→new
-- table. We only map the ones with no default.
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
  callback = function(args)
    local bufmap = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = desc })
    end
    bufmap("n", "gd", vim.lsp.buf.definition,      "LSP: definition")
    bufmap("n", "gD", vim.lsp.buf.declaration,     "LSP: declaration")
    bufmap("n", "go", vim.lsp.buf.type_definition, "LSP: type definition")
    bufmap("n", "gs", vim.lsp.buf.signature_help,  "LSP: signature help")
  end,
})
