-- Single source of truth for plugin specs. vim.pack.add is synchronous and
-- blocks for missing plugins, so one big call parallelizes first-launch
-- installs. Per-plugin configuration lives in lua/plugins/<name>.lua.
--
-- Useful commands:
--   :lua vim.pack.update()     -- update all
--   :lua =vim.pack.get()       -- list installed

vim.pack.add({
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },

  -- Treesitter: pin to the `main` branch (the rewrite — recommended on 0.11+).
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", name = "nvim-treesitter", version = "main" },
  { src = "https://github.com/HiPhish/rainbow-delimiters.nvim", name = "rainbow-delimiters" },

  -- LSP: lspconfig provides per-server defaults via lsp/<name>.lua on the
  -- runtimepath. We don't call its setup() — just vim.lsp.config / .enable.
  { src = "https://github.com/neovim/nvim-lspconfig", name = "nvim-lspconfig" },

  -- Cross-pane navigation between nvim splits and kitty panes. Companion
  -- pass_keys.py kitten lives in ~/.config/kitty/.
  { src = "https://github.com/knubie/vim-kitty-navigator", name = "vim-kitty-navigator" },

  -- Completion. Pinned to a release tag so the prebuilt Rust fuzzy matcher
  -- binary is available — no cargo / build step required.
  { src = "https://github.com/Saghen/blink.cmp", name = "blink.cmp", version = "v1.10.2" },

  -- Clojure: REPL integration + structural editing.
  { src = "https://github.com/Olical/conjure", name = "conjure" },
  { src = "https://github.com/julienvincent/nvim-paredit", name = "nvim-paredit" },

  -- Editing: surround, autopairs, hipatterns, icons — all from mini.nvim.
  -- Git: diff signs, git commands — also from mini.nvim (mini.diff, mini.git).
  { src = "https://github.com/echasnovski/mini.nvim", name = "mini.nvim" },

  -- Git: generate GitHub URLs for current file + line.
  { src = "https://github.com/linrongbin16/gitlinker.nvim", name = "gitlinker.nvim" },

  -- File explorer.
  { src = "https://github.com/nvim-tree/nvim-tree.lua", name = "nvim-tree.lua" },

  -- Enhanced % matching (if/else/end, tags, etc.) via treesitter.
  { src = "https://github.com/andymass/vim-matchup", name = "vim-matchup" },

  -- Markdown rendering (headings, code blocks, tables, callouts, etc.).
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim", name = "render-markdown.nvim" },
})
