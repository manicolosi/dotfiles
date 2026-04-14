# nvim-next

Clean rebuild of the neovim config on 0.12+, using `vim.pack` and builtins
where sensible. Lives alongside the old config via `$NVIM_APPNAME`.

```sh
NVIM_APPNAME=nvim-next nvim   # new config
nvim                          # old config (unchanged)
```

Consider aliasing while iterating:

```sh
alias nv='NVIM_APPNAME=nvim-next nvim'
```

## Reintroduction checklist

Working through `../../nvim/.config/nvim/CAPABILITIES.md` roughly in
break-least-first order. Check off as each lands.

- [ ] 1. Options, leader, clipboard + path-copy keymaps, autocmds
- [ ] 2. `vim.pack` bootstrap + a single colorscheme
- [ ] 3. Treesitter (with `highlight` + `incremental_selection` actually enabled this time)
- [ ] 4. LSP — clojure_lsp, bashls, sqlls, lua_ls + LspAttach keymaps (migrate off deprecated `diagnostic.goto_*` and `vim.lsp.with` handlers)
- [ ] 5. Completion (blink.cmp vs builtin `vim.lsp.completion` — decide)
- [ ] 6. gitsigns + fugitive + gitbrowse
- [ ] 7. Telescope (or fzf-lua / snacks.picker — decide)
- [ ] 8. Conjure + clojure fuzzy indent + sexp keymaps
- [ ] 9. Copilot
- [ ] 10. Notes — pick **one** of neorg / vimwiki
- [ ] 11. Tail: qalc, decisive, kitty-navigator, mini.hipatterns, autopairs, surround, matchup

Anything still unchecked after a couple weeks of daily use is something
we didn't actually miss — drop it.

## Decisions to make up front

- **Plugin manager:** `vim.pack` (builtin, 0.12+). No lazy-loading DSL —
  fine given the old config barely used it.
- **Completion engine:** TBD — blink.cmp (most likely) vs builtin
  `vim.lsp.completion.enable` (minimalist trial).
- **Picker:** TBD — telescope (familiar) vs fzf-lua (faster) vs
  snacks.picker (already have snacks).
- **Notes:** TBD — neorg or vimwiki, not both.
- **File tree:** Likely drop nvim-tree in favor of netrw / oil.nvim /
  mini.files. Decide when we get there.
