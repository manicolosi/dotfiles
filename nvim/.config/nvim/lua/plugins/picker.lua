-- mini.pick: file finder, live grep, LSP symbols.
-- mini.extra: adds LSP, diagnostic, and other pickers on top of mini.pick.
require("mini.pick").setup({
  mappings = {
    -- Send marked items to quickfix. Workflow: <C-a> (mark all) then <C-q>.
    choose_marked = "<C-q>",
  },
  -- Full-width bottom-anchored window (similar to telescope's ivy theme).
  window = {
    config = function()
      local height = math.floor(0.4 * vim.o.lines)
      return {
        anchor = "SW",
        col = 0,
        height = height,
        row = vim.o.lines,
        width = vim.o.columns,
      }
    end,
  },
})
require("mini.extra").setup()

-- Auto-show preview when any picker opens.
vim.api.nvim_create_autocmd("User", {
  pattern = "MiniPickStart",
  callback = function()
    vim.schedule(function()
      local keys = vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
      vim.api.nvim_feedkeys(keys, "n", false)
    end)
  end,
})

-- Key reference:
--   <C-n> / <C-p>     move down / up
--   <Tab>              toggle preview
--   <C-x>             mark/unmark current item
--   <C-a>             mark/unmark all items
--   <C-q>             send marked items to quickfix
--   <CR>              choose current item

vim.keymap.set("n", "<leader>ff", MiniPick.builtin.files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", MiniPick.builtin.grep_live, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fs", function()
  MiniExtra.pickers.lsp({ scope = "document_symbol" })
end, { desc = "LSP document symbols" })
