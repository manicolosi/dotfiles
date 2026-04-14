-- mini.diff: colored line numbers for added/changed/deleted lines.
-- Defaults to 'number' style when line numbers are on (matches our options).
-- Uses git index as the reference source by default.
require("mini.diff").setup()

-- mini.git: lightweight git commands. Replaces fugitive.
-- :Git blame -- %   opens blame in a split (equivalent to :Gblame).
-- :Git log --oneline   etc.
require("mini.git").setup()

-- gitlinker: generate GitHub URLs for current file + line(s).
-- GitLink copies to clipboard; GitLink! opens in browser.
-- Works in visual mode for line ranges.
require("gitlinker").setup()

-- Hunk navigation provided by mini.bracketed ([h / ]h).

-- Open file on GitHub at current line (normal) or line range (visual).
vim.keymap.set({ "n", "v" }, "<leader>gb", "<cmd>GitLink!<cr>", { desc = "Open on GitHub" })
