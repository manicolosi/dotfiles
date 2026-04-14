-- Colorscheme + highlight tweaks. Wrapped in a ColorScheme autocmd so the
-- tweaks survive ad-hoc `:colorscheme X` swaps.
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("UserHighlights", { clear = true }),
  callback = function()
    vim.api.nvim_set_hl(0, "Comment",     { italic = true })
    vim.api.nvim_set_hl(0, "MatchParen",  { fg = "orange", bold = true })
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = "white" })

    -- Darken the statusline devinfo/fileinfo backgrounds (surface0 instead of surface1).
    for _, name in ipairs({ "MiniStatuslineDevinfo", "MiniStatuslineFileinfo" }) do
      local hl = vim.api.nvim_get_hl(0, { name = name })
      hl.bg = 0x3b3c4f -- between catppuccin surface0 and surface1
      vim.api.nvim_set_hl(0, name, hl)
    end

    -- Remove italics from diagnostic highlights (catppuccin sets them italic).
    for _, name in ipairs({ "DiagnosticError", "DiagnosticWarn", "DiagnosticInfo", "DiagnosticHint" }) do
      local hl = vim.api.nvim_get_hl(0, { name = name })
      hl.italic = false
      vim.api.nvim_set_hl(0, name, hl)
    end
  end,
})

vim.cmd.colorscheme("catppuccin-mocha")
