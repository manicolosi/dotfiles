local opt = vim.opt

-- Behavior
opt.mouse = "a"
opt.autoread = true
opt.hidden = true
opt.showcmd = true
opt.scrolloff = 5
opt.backspace = { "indent", "eol", "start" }

-- UI
opt.termguicolors = true
opt.cursorline = true
opt.number = true
opt.signcolumn = "yes"
opt.laststatus = 2
opt.showmode = false
opt.cpoptions:append("n") -- wrapped text uses the line-number column
opt.list = true
opt.listchars = { tab = "→·", trail = "·" }
opt.wildmenu = true

-- Search
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Indent / formatting
opt.autoindent = true
opt.smartindent = true
opt.smarttab = true
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.textwidth = 80
opt.formatoptions:remove("t")

-- Persistence — share undo history with vim
opt.undofile = true
opt.undodir = vim.fn.expand("~/.vim/undo")
