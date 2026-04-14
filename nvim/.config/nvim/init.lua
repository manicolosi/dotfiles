-- Neovim config — rebuilt on 0.12+ using vim.pack.

-- Disable netrw (nvim-tree replaces it).
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Leader must be set before any plugin or mapping that uses <leader>.
vim.g.mapleader = ","
vim.g.maplocalleader = ","

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.pack")

require("plugins.ui")
require("plugins.treesitter")
require("plugins.completion") -- before lsp: lsp.lua reads blink's capabilities
require("plugins.lsp")
require("plugins.editing")
require("plugins.clojure")
require("plugins.git")
require("plugins.picker")
require("plugins.notes")
require("plugins.explorer")
