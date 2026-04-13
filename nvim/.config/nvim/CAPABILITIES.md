# Neovim Config — Capability Inventory

Snapshot of what this config actually _does_, organized by capability rather
than by plugin. The parenthetical after each feature notes what's providing
it today. Kept alongside `init.lua` so the next round of cleanup has a clear
baseline.

**Environment:** neovim 0.11.3 (brew has 0.12.1 available). Single-file config
(`init.lua`, ~779 lines). Plugins managed by `lazy.nvim`.

---

## 1. Plugin manager & bootstrap
- Auto-clones `lazy.nvim` stable branch into `stdpath("data")/lazy` on first
  run. (lazy.nvim)
- `lazy-lock.json` pins commits of every plugin.
- Netrw disabled up front (`loaded_netrw` / `loaded_netrwPlugin`).

## 2. Theme & appearance
- **Active colorscheme:** `catppuccin-mocha`.
- **Installed but unused:** tokyonight, gruvbox, base16-nvim. (Three dormant
  colorscheme plugins — candidate for removal.)
- Statusline: **lualine** with branch/diff/diagnostics in `b`,
  encoding/fileformat/filetype in `x`.
- **Icons:** nvim-web-devicons.
- **Rainbow parens:** rainbow-delimiters.nvim with custom TSRainbow* colors.
- **Tweaks:** italic `Comment`, orange bold `MatchParen`, white `FloatBorder`.
- `termguicolors` on, `cursorline`, `signcolumn=yes`, `number`, `noshowmode`,
  custom `listchars` (tab `→·`, trail `·`).

## 3. LSP
- Uses the new `vim.lsp.config` / `vim.lsp.enable` API (already off
  nvim-lspconfig's `setup()` style).
- **Enabled servers:** `clojure_lsp`, `bashls`, `sqlls`, `lua_ls` (lua_ls gets
  the usual vim-global + runtime-path config).
- Default client capabilities extended via `cmp_nvim_lsp`.
- **Hover / signatureHelp:** rounded borders.
- **Diagnostics:** sign icons (error/warn/info/hint), `virtual_text = false`,
  `severity_sort = true`, `underline`, `update_in_insert = false`. Float uses
  rounded border.
- **LspInfo:** rounded window border via `FileType lspinfo` autocmd.
- **LspAttach keymaps** (buffer-local): `K` hover, `gd` definition,
  `gD` declaration, `gi` implementation, `go` type-definition, `gr` references,
  `gs` signature help, `rn` rename, `<F4>` code action (n + x).
- **Global diagnostic keymaps:** `gl` open_float, `[d` / `]d` prev/next.

## 4. Completion & snippets
- **Engine:** nvim-cmp with bordered completion + documentation windows.
- **Sources** (priority in parens): luasnip (100), nvim_lsp (50), buffer (10),
  plus neorg, path, cmdline (`/` and `?` use buffer; `:` uses path+cmdline).
- **Kind / menu icons** customized via `formatting.format`.
- **Keys:** `C-n`/`C-p` select, `C-u`/`C-d` scroll docs, `C-e` abort,
  `C-y` confirm(select=true), `<CR>` confirm(select=false),
  `C-f`/`C-b` luasnip jump fwd/back, `Tab`/`S-Tab` smart cycle/trigger.
- **Snippets:** LuaSnip + friendly-snippets; both vscode and snipmate loaders
  lazy-loaded.

## 5. Treesitter
- `nvim-treesitter` installed with `:TSUpdate` build hook.
- ⚠️ **Main `treesitter.configs.setup` block is commented out** — no
  `highlight.enable`, no `incremental_selection`, no matchup integration
  currently active. Highlighting only works for parsers that self-register.
- `frankitox/nvim-treesitter-sexp` installed; its `setup` call is also
  commented out, so none of the `<e` / `>f` / slurp/barf keymaps fire.
- `nvim-treesitter-textobjects` pulled in as a neorg dep only.

## 6. File explorer & finder
- **Tree:** `nvim-tree.lua`, toggle with `<leader>tf`
  (`:NvimTreeFindFileToggle`).
- **Telescope** with custom `telescope_dropdown` helper using the `ivy` theme:
  `<leader>ff` find_files, `<leader>fF` git_files, `<leader>fg` live_grep,
  `<leader>fG` grep_string, `<leader>fb` buffers, `<leader>fh` help_tags,
  `<leader>fs` lsp_document_symbols (⚠️ passes the string
  `"builtin.lsp_document_symbols"` — likely broken; should be
  `"lsp_document_symbols"`).

## 7. Git
- **Fugitive** for porcelain commands.
- **gitsigns** configured with `signcolumn = false`, `numhl = true` (highlights
  line numbers instead of drawing a gutter).
- **Browse:** `<leader>gb` (n + v) → `Snacks.gitbrowse()`.

## 8. Editing core
- tpope trio: **vim-surround**, **vim-unimpaired**, **vim-repeat**.
- **vim-qf** — quickfix toggle on `<leader>cc`.
- **vim-matchup** with `matchparen_offscreen` disabled.
- **ultimate-autopair** (v0.6 branch) with clojure-specific pair rules
  suppressing `'` and `` ` `` pairing.
- **mini.nvim** loaded but **only `mini.hipatterns` used** — highlights
  `FIXME`/`HACK`/`TODO`/`NOTE` tokens and hex colors. The rest of mini is
  dead weight right now.

## 9. Clojure / Lisp
- **Conjure** with `highlight.enabled = 1`, HUD width `1.0`.
- treesitter-sexp present (but disabled — see §5).
- `g:clojure_fuzzy_indent_patterns` extended with `dofor`, and ring verbs
  `GET`/`POST`/`PUT`/`PATCH`/`DELETE`/`ANY`.
- Autopair clojure exceptions (§8).

## 10. Notes
- **neorg** (ft/cmd-lazy) with heavy dep tree (luarocks.nvim, plenary,
  treesitter, treesitter-textobjects, nvim-cmp, neorg-telescope). Workspaces:
  `Notes = ~/Nextcloud/Notes`, `Work = ~/Nextcloud/Work`. Default keybinds
  under `<LocalLeader><LocalLeader>`. `<leader>nw` / `<leader>nf` for
  workspace switch / find.
- **vimwiki** pointed at `~/vimwiki` (markdown, `.md`, `global_ext = 0` so it
  doesn't steal every markdown file).
- ⚠️ neorg + vimwiki is redundant for most workflows.

## 11. AI assistance
- **github/copilot.vim**: `<C-l>` accept (wraps `copilot#Accept("<CR>")`),
  `<C-j>` / `<C-k>` next/prev, `<C-\>` dismiss.
- **avante.nvim** block is commented out (bedrock provider config preserved).

## 12. Terminal / window nav
- `knubie/vim-kitty-navigator` — cross-kitty-pane splits navigation.

## 13. Misc plugins
- **qalc.nvim** — libqalculate integration.
- **decisive.nvim** — CSV alignment, lazy on `csv` ft. Keys: `<leader>cca`
  align, `<leader>ccA` clear, `[c` / `]c` prev/next column.
- **snacks.nvim** — only `gitbrowse` used today.

## 14. Options, keymaps & vim-cmd block
- Leader & localleader = `,`.
- **Clipboard:** `<leader>y`/`<leader>Y` → `*`, `<leader>d`/`<leader>D` → `+`,
  `<leader>p`/`<leader>P` ← `+`. (Asymmetry: yank uses `*`, delete/paste use
  `+` — worth normalizing.)
- **Path helpers:** `<leader>yp` copy relative path; `<leader>yl` copy
  `path:line` (normal) or `path:start-end` (visual).
- **Wrap in parens:** `<leader>w` → `ysie)ax<LEFT><C-O>r<SPACE>` (wrap
  inner-expr in `()` and add trailing space);
  `<leader>W` → `ysif)a` (wrap inner-function).
- **Reformat paragraph:** `==` → `mzvaf=0<Esc>\`z`.
- **Visual paste keeps register:** `x p → pgvy`.
- **Mouse scroll:** single-line (`<C-Y>`/`<C-E>` in normal + insert).
- Search: `hlsearch`, `incsearch`, `ignorecase`, `smartcase`.
- Indent: `autoindent`, `smartindent`, `smarttab`, `expandtab`, sw/ts = 2,
  `textwidth = 80`, `formatoptions -= t`.
- Undo: `undofile`, `undodir = ~/.vim/undo`. Swap `directory = $HOME/tmp`.
- `set hidden`, `scrolloff = 5`, `wildmenu`, `showcmd`, `laststatus = 2`,
  `cpoptions += n`.

---

## Known issues / smells found during inventory

1. **`completeopt` set twice, conflicting.** Lua block sets
   `menuone,noselect,fuzzy,nosort`; the later `vim.cmd` block resets it to
   `longest,menuone`, so the fuzzy/nosort options never take effect.
2. **Treesitter not actually configured.** `nvim-treesitter.configs.setup` is
   commented out; treesitter-sexp's setup is also commented out. Either
   re-enable or drop the plugins.
3. **`<leader>fs` telescope binding passes a bad picker name**
   (`"builtin.lsp_document_symbols"`). Should just be
   `"lsp_document_symbols"`.
4. **Three unused colorschemes** (tokyonight, gruvbox, base16) loaded eagerly
   with `priority = 1000`. Clutters `:Lazy` and adds start-up cost.
5. **mini.nvim pulled for one module.** Either swap for
   `echasnovski/mini.hipatterns` directly or adopt more mini modules
   (mini.surround, mini.pairs, mini.comment, mini.statusline can replace
   several current plugins).
6. **neorg + vimwiki overlap.** Both are note systems; pick one.
7. **Deprecated diagnostic API.** `vim.diagnostic.goto_prev/next` are
   deprecated in 0.11; should migrate to `vim.diagnostic.jump({count=…})`.
   Similarly, hover/signatureHelp `vim.lsp.with` handler overrides are the
   old pattern — 0.11+ prefers `vim.lsp.buf.hover({border = "rounded"})` and
   global `vim.o.winborder`.
8. **avante.nvim + sexp/autopairs commented-out blocks** should just be
   deleted — they're dead code in the file.
9. **nvim-lspconfig is listed as a plugin but unused** now that we're on
   `vim.lsp.config` / `vim.lsp.enable`. Safe to drop.
10. **nvim-tree vs snacks.explorer / oil.nvim / mini.files** — current nvim
    has enough built-in file-manipulation primitives that nvim-tree is
    optional.
11. **Clipboard keymap asymmetry** (`*` for yank, `+` for delete/paste — see
    §14).
12. **Neovim is a minor version behind** (0.11.3 vs brew's 0.12.1); 0.12
    ships `vim.pack` (builtin plugin manager) and a bunch of LSP/diagnostic
    ergonomics that affect the cleanup agenda.
