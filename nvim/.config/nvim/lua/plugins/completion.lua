require("blink.cmp").setup({
  -- LSP completions sometimes arrive as snippet items even though we don't
  -- author snippets ourselves — the "default" engine uses builtin
  -- vim.snippet to expand them. Zero deps.
  snippets = { preset = "default" },

  sources = {
    default = { "lsp", "buffer", "path" },
  },

  -- Cmdline completion: replaces cmp-cmdline. Auto-show menu while typing.
  cmdline = {
    enabled = true,
    completion = {
      menu = { auto_show = true },
    },
  },

  -- Preserve the keymap shape from the old nvim-cmp config exactly.
  -- preset = "none" turns off blink defaults so we can map only what we want.
  keymap = {
    preset = "none",

    ["<C-n>"] = { "select_next", "fallback" },
    ["<C-p>"] = { "select_prev", "fallback" },
    ["<C-u>"] = { "scroll_documentation_up", "fallback" },
    ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    ["<C-e>"] = { "hide", "fallback" },
    ["<C-y>"] = { "select_and_accept" },
    ["<CR>"]  = { "accept", "fallback" },

    -- Tab: cycle if menu is up, otherwise trigger completion if we're in
    -- the middle of a word, otherwise fall through to vim's normal Tab
    -- (indent / accept-snippet-jump).
    ["<Tab>"] = {
      function(cmp)
        if cmp.is_visible() then return cmp.select_next() end
        local col = vim.fn.col(".") - 1
        if col > 0 and not vim.fn.getline("."):sub(col, col):match("%s") then
          return cmp.show()
        end
      end,
      "fallback",
    },
    ["<S-Tab>"] = {
      function(cmp)
        if cmp.is_visible() then return cmp.select_prev() end
      end,
      "fallback",
    },
  },

  appearance = {
    nerd_font_variant = "mono",
  },

  completion = {
    list = {
      selection = { preselect = false, auto_insert = true },
    },
    menu = {
      draw = {
        columns = {
          { "kind_icon", "label", "label_description", gap = 1 },
          { "source_name" },
        },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
    },
  },

  -- Use the prebuilt Rust matcher (shipped with the release tag); fall
  -- back to Lua matcher with a warning if the binary isn't present.
  fuzzy = { implementation = "prefer_rust_with_warning" },
})
