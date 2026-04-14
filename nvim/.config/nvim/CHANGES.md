# nvim-next: changes from the old config

Running list of behavior deltas from `~/code/dotfiles/nvim/.config/nvim/` —
mostly muscle-memory shifts and modernized API usage. Append per step.

---

## Step 4 — LSP keymaps

nvim 0.11+ now ships sensible LSP default keymaps under a `g…`-prefix
convention. The old config predates those and used shorter custom keys.
nvim-next adopts the defaults; the table below is the old → new
translation.

### Action → key

| Action                  | Old           | nvim-next           | Source            |
| ----------------------- | ------------- | ------------------- | ----------------- |
| Hover                   | `K`           | `K`                 | nvim default      |
| Rename                  | `rn`          | `grn`               | nvim default      |
| Code action             | `<F4>`        | `gra`               | nvim default      |
| References              | `gr`          | `grr`               | nvim default      |
| Implementation          | `gi`          | `gri`               | nvim default      |
| Document symbol         | —             | `gO`                | nvim default      |
| Signature help (insert) | —             | `<C-S>`             | nvim default      |
| Diagnostic prev / next  | `[d` / `]d`   | `[d` / `]d`         | nvim default      |
| Open diagnostic float   | `gl`          | `gl`                | nvim-next         |
| Definition              | `gd`          | `gd`                | nvim-next         |
| Declaration             | `gD`          | `gD`                | nvim-next         |
| Type definition         | `go`          | `go`                | nvim-next         |
| Signature help (normal) | `gs`          | `gs`                | nvim-next (overrides built-in `gs` sleep) |

### Other LSP changes

- **Dropped `vim.lsp.with` handler overrides** for hover and
  signatureHelp. Replaced with global `vim.o.winborder = "rounded"`,
  which applies to *every* floating window (LSP, lazy, telescope
  previews, etc.) consistently.
- **Dropped the LspInfo border autocmd** — winborder covers it.
- **`vim.diagnostic.goto_prev/next`** (deprecated in 0.11) → defaults now
  use `vim.diagnostic.jump({ count = ±1, float = true })`.
- **`cmp_nvim_lsp` capabilities** are not wired in yet — comes back in
  step 5 (completion).
- **lua_ls** is now configured with the nvim runtime in
  `workspace.library`, so `vim` is no longer flagged as an undefined
  global when editing nvim-next files (the warning we'd been seeing on
  every save).

---

## Step 5 — Completion

Switched from **nvim-cmp + 6 companion source plugins** to **blink.cmp**
(single plugin, sources built-in). Snippets dropped entirely — never
part of the workflow.

### Plugin replacements

| Old (8 plugins)         | nvim-next (1)   |
| ----------------------- | --------------- |
| nvim-cmp                | blink.cmp       |
| cmp-nvim-lsp            | (built-in)      |
| cmp-buffer              | (built-in)      |
| cmp-path                | (built-in)      |
| cmp-cmdline             | (built-in)      |
| cmp_luasnip             | —               |
| LuaSnip                 | —               |
| friendly-snippets       | —               |

### Sources

- `lsp`, `buffer`, `path` enabled by default in normal completion
- Cmdline mode (`:` and `/`/`?`) gets blink's auto-popup
- `neorg` source: deferred to notes step (and may not return at all)

### Keymap (preserved from old config)

| Action                   | Key             |
| ------------------------ | --------------- |
| Select next / prev       | `<C-n>` / `<C-p>` |
| Scroll docs up / down    | `<C-u>` / `<C-d>` |
| Abort                    | `<C-e>`         |
| Confirm (auto-select)    | `<C-y>`         |
| Confirm (no auto-select) | `<CR>`          |
| Smart cycle / trigger    | `<Tab>` / `<S-Tab>` |

Removed: `<C-f>` / `<C-b>` (LuaSnip jump fwd/back — no snippets now).

### LSP capabilities

`vim.lsp.config('*', { capabilities = … })` now uses
`require('blink.cmp').get_lsp_capabilities()` (replaces
`require('cmp_nvim_lsp').default_capabilities()`).

---

## Clojure + editing step

### Plugin replacements

| Old                      | nvim-next             | Notes                              |
| ------------------------ | --------------------- | ---------------------------------- |
| vim-surround             | **mini.surround**     | Same `ys`/`cs`/`ds` keys          |
| vim-repeat               | —                     | mini.surround has native dot-repeat |
| ultimate-autopair        | **mini.pairs**        | Per-filetype exceptions in clojure.lua |
| nvim-web-devicons        | **mini.icons**        | Same nerd font icons               |
| —                        | **mini.hipatterns**   | Pulled forward from step 11        |
| Conjure                  | **Conjure**           | Same                               |
| frankitox/treesitter-sexp| **same**              | Default keymaps, no setup needed   |

All four mini modules come from one plugin (`echasnovski/mini.nvim`).

### Surround keymaps (unchanged)

| Action      | Key      |
| ----------- | -------- |
| Add         | `ys{motion}{char}` (e.g. `ysiw)`) |
| Delete      | `ds{char}` (e.g. `ds"`) |
| Change      | `cs{old}{new}` (e.g. `cs"'`) |
| Visual      | `S{char}` |

### Surround — old `csw` habit

`csw` is not available in mini.surround (or standard vim-surround).
Use `ysiw)` to wrap a word in parens, `ysiw"` to wrap in quotes, etc.
In clojure: `,w` wraps the element (word or form) under cursor in
`()` with trailing space and enters insert mode.

### Structural editing — treesitter-sexp → nvim-paredit

Swapped `frankitox/nvim-treesitter-sexp` for `julienvincent/nvim-paredit`
(treesitter-sexp crashed on nvim-treesitter `main` branch). Same keymaps:

| Action         | Key                    |
| -------------- | ---------------------- |
| Slurp fwd/back | `>)` / `<(`            |
| Barf fwd/back  | `<)` / `>(`            |
| Swap elem      | `>e` / `<e`            |
| Swap form      | `>f` / `<f`            |
| Drag pair      | `>p` / `<p` (new)      |
| Raise form     | `<LocalLeader>o`       |
| Raise elem     | `<LocalLeader>O`       |
| Splice         | `<LocalLeader>@`       |
| Form start/end | `(` / `)`              |
| Inner/outer form | `if` / `af`          |
| Inner/outer elem | `ie` / `ae`          |

### Clojure autopair exceptions

`'` and `` ` `` do not auto-pair in clojure buffers (quote and
syntax-quote).
