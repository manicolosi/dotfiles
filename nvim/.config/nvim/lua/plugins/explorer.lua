require("nvim-tree").setup({})

-- Toggle tree and reveal current file (same as old config's <leader>tf).
vim.keymap.set("n", "<leader>tf", ":NvimTreeFindFileToggle<CR>", { silent = true, desc = "Toggle file tree (reveal current file)" })
