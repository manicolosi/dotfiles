-- nvim-treesitter (main branch): parsers are installed explicitly; features
-- (highlight, folds) are enabled per-buffer via vim.treesitter.start() in a
-- FileType autocmd rather than a global setup{} block.
--
-- rainbow-delimiters auto-attaches to any buffer with treesitter active —
-- no setup call needed.

local parsers = {
  "lua", "vim", "vimdoc", "query",
  "bash",
  "clojure",
  "sql",
  "markdown", "markdown_inline",
  "json", "yaml", "toml",
  "html", "css", "javascript", "typescript",
}

require("nvim-treesitter").install(parsers)

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if not lang or not vim.treesitter.language.add(lang) then
      return
    end
    vim.treesitter.start(args.buf, lang)
    -- Use the explicit option-value API with scope = "local" rather than
    -- vim.wo — vim.wo can race with window setup during FileType.
    vim.api.nvim_set_option_value("foldmethod", "expr", { scope = "local" })
    vim.api.nvim_set_option_value("foldexpr", "v:lua.vim.treesitter.foldexpr()", { scope = "local" })
    -- rainbow-delimiters registered its FileType autocmd when its plugin
    -- file loaded (before ours), so it tried to attach before TS was up
    -- and skipped. Manually attach now that the parser is live.
    pcall(function()
      require("rainbow-delimiters.lib").attach(args.buf)
    end)
  end,
})

-- Folds available via treesitter, but files open fully expanded.
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
