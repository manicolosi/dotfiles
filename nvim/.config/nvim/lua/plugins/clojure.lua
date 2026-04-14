-- Conjure (REPL integration).
vim.g["conjure#highlight#enabled"] = true
vim.g["conjure#log#hud#enabled"] = false  -- no floating popup on connect/disconnect
vim.g["conjure#log#hud#width"] = "1.0"
vim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = false  -- don't auto-connect; use :ConjureConnect

-- Quick-connect: opens command line pre-filled so you can tweak the port.
local conjure_connect_cmd
if vim.fn.hostname() == "isengard.nicolosi.me" then
  conjure_connect_cmd = ":ConjureConnect local.aclaimant.com 7000"
else
  conjure_connect_cmd = ":ConjureConnect localhost "
end
vim.keymap.set("n", "<leader>cc", function()
  vim.api.nvim_feedkeys(conjure_connect_cmd, "n", false)
end, { desc = "ConjureConnect (editable)" })

-- nvim-paredit: structural editing (slurp, barf, swap, raise, splice, etc.)
-- Default keymaps match the old treesitter-sexp bindings. See :h nvim-paredit.
require("nvim-paredit").setup()

-- Wrap the element under cursor (word, symbol, or form) in () with a
-- trailing space, ending in insert mode: foobar → (foobar |)
-- Uses paredit's `ie` textobject so it works on both words and forms.
vim.keymap.set("n", "<leader>w", [[vie"zc(<C-r>z )<Esc>F a]], {
  remap = true,
  desc = "Wrap element in () and enter insert mode",
})

-- Compojure / ring route verbs get clojure-style indentation.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("UserClojure", { clear = true }),
  pattern = "clojure",
  callback = function()
    vim.g.clojure_fuzzy_indent_patterns = vim.list_extend(
      vim.g.clojure_fuzzy_indent_patterns or {},
      { "^dofor$", "^GET$", "^POST$", "^PUT$", "^PATCH$", "^DELETE$", "^ANY$" }
    )

    -- == re-indents the outer form (instead of vim's default single-line indent).
    vim.keymap.set("n", "==", "mzvaf=`z", { buffer = true, remap = true, desc = "Re-indent outer form" })

    -- In clojure, ' is quote and ` is syntax-quote — don't auto-pair them.
    vim.keymap.set("i", "'", "'", { buffer = true })
    vim.keymap.set("i", "`", "`", { buffer = true })
  end,
})
