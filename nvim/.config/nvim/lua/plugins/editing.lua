-- vim-matchup: enhanced % for if/else/end, tags, etc. Disable the
-- offscreen match popup (shows when matching pair is scrolled away).
vim.g.matchup_matchparen_offscreen = { method = "" }

-- mini.surround: tpope vim-surround keybindings (ys/cs/ds), native
-- dot-repeat, treesitter-aware. Replaces vim-surround + vim-repeat.
require("mini.surround").setup({
  mappings = {
    add = "ys",
    delete = "ds",
    replace = "cs",
    find = "",
    find_left = "",
    highlight = "",
    update_n_lines = "",
    suffix_last = "",
    suffix_next = "",
  },
})
-- mini.surround maps `ys` in visual mode too, but the convention there is
-- `S` (from vim-surround). Remap to match.
vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })

-- mini.pairs: auto-close brackets/quotes on insert. Per-filetype exceptions
-- for clojure ' and ` are in lua/plugins/clojure.lua.
require("mini.pairs").setup()

-- mini.hipatterns: highlight FIXME/HACK/TODO/NOTE tokens and hex colors
-- inline. Ported from old config.
local hipatterns = require("mini.hipatterns")
hipatterns.setup({
  highlighters = {
    fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
    hack  = { pattern = "%f[%w]()HACK()%f[%W]",  group = "MiniHipatternsHack" },
    todo  = { pattern = "%f[%w]()TODO()%f[%W]",   group = "MiniHipatternsTodo" },
    note  = { pattern = "%f[%w]()NOTE()%f[%W]",   group = "MiniHipatternsNote" },
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})

-- mini.icons: nerd font icons for blink.cmp kind icons, statusline, pickers,
-- etc. Replaces nvim-web-devicons.
require("mini.icons").setup()

-- mini.statusline: mode-colored statusline with branch, diagnostics, filename,
-- fileinfo, and cursor position. Replaces lualine. Custom active content to:
--   1. Color diagnostic counts individually (error=red, warn=yellow, etc.)
--   2. Show filename relative to cwd (not full path)
--   3. Show location as line:col + scroll percentage

-- Create diagnostic highlight groups that preserve the devinfo background.
local function setup_statusline_diag_hls()
  local bg = vim.api.nvim_get_hl(0, { name = "MiniStatuslineDevinfo" }).bg
  for _, info in ipairs({
    { src = "DiagnosticError", dst = "StatuslineDiagERROR" },
    { src = "DiagnosticWarn",  dst = "StatuslineDiagWARN" },
    { src = "DiagnosticInfo",  dst = "StatuslineDiagINFO" },
    { src = "DiagnosticHint",  dst = "StatuslineDiagHINT" },
  }) do
    local fg = vim.api.nvim_get_hl(0, { name = info.src }).fg
    vim.api.nvim_set_hl(0, info.dst, { fg = fg, bg = bg })
  end
end
setup_statusline_diag_hls()
-- Re-create after colorscheme changes.
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("StatuslineDiagHl", { clear = true }),
  callback = setup_statusline_diag_hls,
})

local function statusline_diagnostics()
  local count = vim.diagnostic.count(0)
  local levels = {
    { name = "ERROR", sign = " ", hl = "DiagnosticError" },
    { name = "WARN",  sign = " ", hl = "DiagnosticWarn" },
    { name = "INFO",  sign = " ", hl = "DiagnosticInfo" },
    { name = "HINT",  sign = " ", hl = "DiagnosticHint" },
  }
  local parts = {}
  for _, level in ipairs(levels) do
    local n = count[vim.diagnostic.severity[level.name]] or 0
    if n > 0 then
      table.insert(parts, "%#StatuslineDiag" .. level.name .. "#" .. level.sign .. n)
    end
  end
  return table.concat(parts, " ")
end

local function statusline_filename()
  if vim.bo.buftype == "terminal" then return "%t" end
  return "%f%m%r"
end

-- Custom fileinfo: colored filetype icon + format/encoding icons.
local format_icons = {
  unix = vim.fn.nr2char(0xF17C),  -- tux
  dos  = vim.fn.nr2char(0xF17A),  -- windows
  mac  = vim.fn.nr2char(0xF179),  -- apple
}

local function statusline_fileinfo()
  local ft = vim.bo.filetype
  if ft == "" then return "" end

  -- Filetype icon colored but with the fileinfo background preserved.
  local icon, icon_hl = MiniIcons.get("filetype", ft)
  local icon_fg = vim.api.nvim_get_hl(0, { name = icon_hl }).fg
  local fi_bg = vim.api.nvim_get_hl(0, { name = "MiniStatuslineFileinfo" }).bg
  vim.api.nvim_set_hl(0, "StatuslineFileIcon", { fg = icon_fg, bg = fi_bg })
  local colored_ft = "%#StatuslineFileIcon#" .. icon .. " " .. ft

  if vim.bo.buftype ~= "" then return colored_ft end

  local format = format_icons[vim.bo.fileformat] or vim.bo.fileformat

  return colored_ft .. "%#MiniStatuslineFileinfo# " .. format
end

require("mini.statusline").setup({
  content = {
    active = function()
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
      local git      = MiniStatusline.section_git({ trunc_width = 40 })
      local diff     = MiniStatusline.section_diff({ trunc_width = 75 })
      if diff:match("%-$") then diff = "" end
      local diag     = statusline_diagnostics()
      local filename = statusline_filename()
      local fileinfo = statusline_fileinfo()
      local location = "%p%% %l:%v"
      local search   = MiniStatusline.section_searchcount({ trunc_width = 75 })

      -- Prepend LSP icon to diagnostics if any are present.
      -- U+F013 is the larger gear icon (vs U+F085 which is tiny double-gears).
      local lsp_diag = diag
      if diag ~= "" then
        lsp_diag = "%#MiniStatuslineDevinfo#" .. vim.fn.nr2char(0xF013) .. " " .. diag
      end

      return MiniStatusline.combine_groups({
        { hl = mode_hl,                  strings = { mode:upper() } },
        { hl = "MiniStatuslineDevinfo",  strings = { git, diff, lsp_diag ~= "" and "│" or "", lsp_diag } },
        "%<",
        { hl = "MiniStatuslineFilename", strings = { filename } },
        "%=",
        { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
        { hl = mode_hl,                  strings = { search, location } },
      })
    end,
  },
})

-- mini.bracketed: [b/]b buffers, [q/]q quickfix, [d/]d diagnostics,
-- [f/]f files, [h/]h hunks, etc. Replaces vim-unimpaired.
require("mini.bracketed").setup()
