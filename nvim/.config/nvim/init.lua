vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Themes
  {'folke/tokyonight.nvim', lazy = false, priority = 1000},
  {"catppuccin/nvim", name = "catppuccin", priority = 1000},
  {"ellisonleao/gruvbox.nvim", priority = 1000},
  -- Pretty
  "nvim-lualine/lualine.nvim",
  {"nvim-tree/nvim-web-devicons", lazy = true},
  -- Syntax
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  "HiPhish/rainbow-delimiters.nvim",
  -- LSP
  "neovim/nvim-lspconfig",
  -- Clojure
  "Olical/conjure",
  -- Completion
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/nvim-cmp",
  "saadparwaiz1/cmp_luasnip",
  { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
  "rafamadriz/friendly-snippets",
  -- Finder
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  -- Terminal Integration
  "knubie/vim-kitty-navigator",
  -- Git Integration
  "tpope/vim-fugitive",
  "lewis6991/gitsigns.nvim",
  -- "ruanyl/vim-gh-line",
  -- Core
  "tpope/vim-surround",
  "tpope/vim-unimpaired",
  "tpope/vim-repeat",
  "romainl/vim-qf",
  { 'echasnovski/mini.nvim', version = false },
  {
    "andymass/vim-matchup",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "" }
    end
  },
  { "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
    end
  },
  -- Lisp stuff
  --{
  --  "guns/vim-sexp",
  --  config = function()
  --    vim.g.sexp_enable_insert_mode_mappings = 0
  --  end
  --},
  --"tpope/vim-sexp-mappings-for-regular-people",
  --{
  --  "windwp/nvim-autopairs",
  --  event = "InsertEnter",
  --  opts = {}
  --},
  {
    'altermo/ultimate-autopair.nvim',
    event = {'InsertEnter','CmdlineEnter'},
    branch ='v0.6', --recomended as each new version will have breaking changes
    opts = {
      config_internal_pairs = {
        {"'","'", nft = {"clojure"}},
        {"`","`", nft = {"clojure"}},
      }
    }
  },
  "github/copilot.vim",
  --"PaterJason/nvim-treesitter-sexp",
  "frankitox/nvim-treesitter-sexp",
  {
    "vimwiki/vimwiki",
    init = function()
      vim.g.vimwiki_list = {
        {
          path = '~/vimwiki',
          syntax = 'markdown',
          ext = '.md',
        },
      }
      vim.g.vimwiki_auto_header = 1
      vim.g.vimwiki_links_space_char = '_'
      vim.g.vimwiki_global_ext = 0
    end,
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },
  {
    "nvim-neorg/neorg",
    ft = "norg",
    cmd = "Neorg",
    dependencies = {
      "luarocks.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-cmp",
      "nvim-lua/plenary.nvim",
      "nvim-neorg/neorg-telescope",
    },
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.export"] = {},
          ["core.ui.calendar"] = {},
          ["core.integrations.telescope"] = {},
          ["core.integrations.nvim-cmp"] = {},
          ["core.completion"] = { config = { engine = "nvim-cmp" } },
          ["core.concealer"] =
          {
            config = {
              folds = false,
              icons = {
                todo = {
                  undone = {
                    icon = " "
                  }
                }
              }

            }
          },
          ["core.keybinds"] = {
            -- https://github.com/nvim-neorg/neorg/blob/main/lua/neorg/modules/core/keybinds/keybinds.lua
            config = {
              default_keybinds = true,
              neorg_leader = "<Leader><Leader>",
            },
          },
          ["core.dirman"] = {
            config = {
              workspaces = {
                Notes = "~/Nextcloud/Notes",
                Work = "~/Nextcloud/Work",
              }
            }
          }
        }
      })
    end
  },
  {
    "emmanueltouzery/decisive.nvim",
    config = function()
      require('decisive').setup{}
    end,
    lazy=true,
    ft = {'csv'},
    keys = {
      { '<leader>cca', ":lua require('decisive').align_csv({})<cr>",       { silent = true }, desc = "Align CSV",          mode = 'n' },
      { '<leader>ccA', ":lua require('decisive').align_csv_clear({})<cr>", { silent = true }, desc = "Align CSV clear",    mode = 'n' },
      { '[c', ":lua require('decisive').align_csv_prev_col()<cr>",         { silent = true }, desc = "Align CSV prev col", mode = 'n' },
      { ']c', ":lua require('decisive').align_csv_next_col()<cr>",         { silent = true }, desc = "Align CSV next col", mode = 'n' },
    }
  },
  'Apeiros-46B/qalc.nvim',
  --{
  --  "yetone/avante.nvim",
  --  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --  -- ⚠️ must add this setting! ! !
  --  build = function()
  --    -- conditionally use the correct build system for the current OS
  --    if vim.fn.has("win32") == 1 then
  --      return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
  --    else
  --      return "make"
  --    end
  --  end,
  --  event = "VeryLazy",
  --  version = false, -- Never set this value to "*"! Never!
  --  opts = {
  --    provider = "bedrock",
  --    providers = {
  --      bedrock = {
  --        --model = "anthropic.claude-3-7-sonnet-20250219-v1:0",
  --        model = "us.anthropic.claude-3-5-sonnet-20241022-v2:0",
  --        aws_profile = "aclaimant",
  --        aws_region = "us-east-1",
  --        timeout = 30000,
  --        extra_request_body = {
  --          temperature = 0.75,
  --          max_tokens = 20480,
  --        },
  --      },
  --    },
  --  },
  --  dependencies = {
  --    "nvim-lua/plenary.nvim",
  --    "MunifTanjim/nui.nvim",
  --    --- The below dependencies are optional,
  --    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
  --    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
  --    "folke/snacks.nvim", -- for input provider snacks
  --    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
  --    "zbirenbaum/copilot.lua", -- for providers='copilot'
  --    {
  --      -- support for image pasting
  --      "HakonHarnes/img-clip.nvim",
  --      event = "VeryLazy",
  --      opts = {
  --        -- recommended settings
  --        default = {
  --          embed_image_as_base64 = false,
  --          prompt_for_file_name = false,
  --          drag_and_drop = {
  --            insert_mode = true,
  --          },
  --          -- required for Windows users
  --          use_absolute_path = true,
  --        },
  --      },
  --    },
  --    {
  --      -- Make sure to set this up properly if you have lazy=true
  --      'MeanderingProgrammer/render-markdown.nvim',
  --      opts = {
  --        file_types = { "markdown", "Avante" },
  --      },
  --      ft = { "markdown", "Avante" },
  --    },
  --  },
  --}
  {
    "folke/snacks.nvim",
    opts = {
      gitbrowse = {
      }
    }
  }
})

--require('nvim-autopairs').setup({
--  check_ts = true,
--})

local hipatterns = require('mini.hipatterns')
hipatterns.setup({
  highlighters = {
    -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
    fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
    hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
    todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
    note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },

    -- Highlight hex color strings (`#rrggbb`) using that color
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})

require('gitsigns').setup {
  signcolumn = false,
  numhl = true
}

--require('nvim-treesitter.configs').setup {
--  highlight = {
--    enable = true
--  },
--  incremental_selection = {
--    enable = true,
--    keymaps = {
--      init_selection = "<Enter>", -- set to `false` to disable one of the mappings
--      node_incremental = "<Enter>",
--      --scope_incremental = "grc",
--      node_decremental = "<BS>"
--    }
--  },
--  matchup = {
--    enabled = true
--  }
--}

--require("treesitter-sexp").setup {
--  -- Enable/disable
--  enabled = true,
--  -- Move cursor when applying commands
--  set_cursor = true,
--  -- Set to false to disable all keymaps
--  keymaps = {
--    -- Set to false to disable keymap type
--    commands = {
--      -- Set to false to disable individual keymaps
--      swap_prev_elem = "<e",
--      swap_next_elem = ">e",
--      swap_prev_form = "<f",
--      swap_next_form = ">f",
--      promote_elem = "<LocalLeader>O",
--      promote_form = "<LocalLeader>o",
--      splice = "<LocalLeader>@",
--      slurp_left = "<(",
--      slurp_right = ">)",
--      barf_left = ">(",
--      barf_right = "<)",
--      insert_head = "<I",
--      insert_tail = ">I",
--    },
--    motions = {
--      form_start = "(",
--      form_end = ")",
--      prev_elem = "[e",
--      next_elem = "]e",
--      prev_elem_end = "[E",
--      next_elem_end = "]E",
--      prev_top_level = "[[",
--      next_top_level = "]]",
--    },
--    textobjects = {
--      inner_elem = "ie",
--      outer_elem = "ae",
--      inner_form = "if",
--      outer_form = "af",
--      inner_top_level = "iF",
--      outer_top_level = "aF",
--    },
--  },
--}

local luasnip = require("luasnip")
local cmp = require'cmp'
local select_opts = {behavior = cmp.SelectBehavior.Insert}
cmp.setup {
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered()
  },
  formatting = {
    fields = {'menu', 'abbr', 'kind'},
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = '',
        luasnip = '',
        buffer = '',
        path = '',
      }
      local kind_icon = {
        Text = "",
        Function = "󰊕",
        Reference = "󰒗",
        Keyword = "",
        Variable = "󰫧",
      }

      item.kind = string.format('%s %s', kind_icon[item.kind] or " ", item.kind)
      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
    ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),

    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.confirm({select = true}),
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    ['<C-f>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<C-b>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<Tab>'] = cmp.mapping(function(fallback)
      local col = vim.fn.col('.') - 1

      if cmp.visible() then
        cmp.select_next_item(select_opts)
      elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        fallback()
      else
        cmp.complete()
      end
    end, {'i', 's'}),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_opts)
      else
        fallback()
      end
    end, {'i', 's'}),
  }),
  snippet = {
    expand = function(args)
      require'luasnip'.lsp_expand(args.body)
    end
  },
  sources = cmp.config.sources({
    { name = "neorg" },
    { name = 'nvim_lsp', priority = 50 },
    { name = 'buffer',   priority = 10 },
    { name = 'luasnip',  priority = 100 },
  }),
}
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

require('luasnip.loaders.from_vscode').lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()
--vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
vim.opt.completeopt = {'menuone', 'noselect', 'fuzzy', 'nosort'}

require'lspconfig'.clojure_lsp.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.sqlls.setup{}
require'lspconfig'.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config
lsp_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lsp_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

vim.keymap.set('n', 'gl', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
--vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

local signs = {
  Error = "",
  Warn = "",
  Info = "",
  Hint = ""
}
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = "rounded"
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = "rounded"
  }
)

vim.diagnostic.config {
  float = { border = "rounded" },
  virtual_text = false,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true
}

require('lspconfig.ui.windows').default_options = {
  border = "rounded"
}

--vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white]]

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    --local client = vim.lsp.get_client_by_id(ev.data.client_id)
    --client.server_capabilities.semanticTokensProvider = nil

    local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Displays hover information about the symbol under the cursor
    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

    -- Jump to the definition
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

    -- Jump to declaration
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

    -- Lists all the implementations for the symbol under the cursor
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

    -- Jumps to the definition of the type symbol
    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

    -- Lists all the references 
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

    -- Displays a function's signature information
    bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

    -- Renames all references to the symbol under the cursor
    bufmap('n', 'rn', '<cmd>lua vim.lsp.buf.rename()<cr>')

    -- Selects a code action available at the current cursor position
    bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
  end
})

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'base16',
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.opt.termguicolors = true
--vim.cmd.colorscheme('tokyonight')
--vim.cmd.colorscheme('base16-tomorrow-night')
vim.cmd.colorscheme('catppuccin-mocha')
vim.api.nvim_set_hl(0, 'Comment', { italic=true })
vim.api.nvim_set_hl(0, 'MatchParen', { fg='orange', bold=true })


--vim.g["conjure#log#hud#enabled"] = false
vim.g["conjure#highlight#enabled"] = true
vim.g["conjure#log#hud#width"] = '1.0'
--vim.g["conjure#log#hud#anchor"] = 'NE'

vim.cmd([[
  set mouse=a
  set autoread
  set laststatus=2
  set cursorline
  set backspace=indent,eol,start

  " Hilight searches and do incremental searches. Also ignore case for searches.
  set hlsearch
  set incsearch
  set ignorecase
  set smartcase

  set completeopt=longest,menuone

  set hidden      " Don't require saving before switching buffers
  set showcmd     " Show command prefixes.
  set wildmenu    " Menu of completions
  set scrolloff=5 " Keep 5 lines of context when scrolling

  "set nobackup
  "set noswapfile
  set directory=$HOME/tmp

  set undofile
  set undodir=~/.vim/undo

  set number
  set cpoptions+=n " Wrapped text uses line number columns

  set listchars=tab:→·,trail:·
  set list

  " Turn on auto indenting.
  set autoindent
  set smartindent
  set smarttab
  set expandtab
  set formatoptions-=t

  set textwidth=80
  set shiftwidth=2
  set tabstop=2

  set signcolumn=yes
  set noshowmode

  highlight TSRainbowRed     guifg=#cc6666
  highlight TSRainbowOrange  guifg=#de935f
  highlight TSRainbowYellow  guifg=#f0c674
  highlight TSRainbowGreen   guifg=#b5bd68
  highlight TSRainbowCyan    guifg=#8abeb7
  highlight TSRainbowBlue    guifg=#81a2be
  highlight TSRainbowViolet  guifg=#b294bb
  highlight MiniHipatternsHack  guibg=None
  highlight MiniHipatternsFixme  guibg=None
  highlight MiniHipatternsTodo  guibg=None
  highlight MiniHipatternsNote  guibg=None

  autocmd FileType clojure let g:clojure_fuzzy_indent_patterns+=['^dofor$', '^GET$', '^POST$', '^PUT$', '^PATCH$', '^DELETE$', '^ANY$']
]])

vim.cmd([[
  " Yank into system clipboard
  "nnoremap v <leader>y "+y
  "nnoremap v <leader>Y "+Y
  nnoremap <leader>y "*y
  nnoremap <leader>Y "*Y

  " Delete into system clipboard
  "nnoremap v <leader>d "+d
  "nnoremap v <leader>D "+D
  nnoremap <leader>d "+d
  nnoremap <leader>D "+D

  " Paste from system clipboard
  nnoremap <leader>p "+p
  nnoremap <leader>P "+P

  " Toggle the quickfix window
  nmap <Leader>cc <Plug>(qf_qf_toggle)

  imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
  imap <silent> <C-j> <Plug>(copilot-next)
  imap <silent> <C-k> <Plug>(copilot-previous)
  imap <silent> <C-\> <Plug>(copilot-dismiss)

  " Normal mode mappings for single-line scroll
  noremap <ScrollWheelUp> <C-Y>
  noremap <ScrollWheelDown> <C-E>

  " Insert mode mappings for single-line scroll
  inoremap <ScrollWheelUp> <C-O><C-Y>
  inoremap <ScrollWheelDown> <C-O><C-E>
]])

local function telescope_dropdown(picker)
  local builtin = require('telescope.builtin')
  local theme = require('telescope.themes').get_ivy({})
  return function()
    builtin[picker](theme)
  end
end

vim.keymap.set('n', '<leader>ff', telescope_dropdown("find_files"), {})
vim.keymap.set('n', '<leader>fF', telescope_dropdown("git_files"), {})
vim.keymap.set('n', '<leader>fg', telescope_dropdown("live_grep"), {})
vim.keymap.set('n', '<leader>fG', telescope_dropdown("grep_string"), {})
vim.keymap.set('n', '<leader>fb', telescope_dropdown("buffers"), {})
vim.keymap.set('n', '<leader>fh', telescope_dropdown("help_tags"), {})
vim.keymap.set('n', '<leader>fs', telescope_dropdown("builtin.lsp_document_symbols"), {})



vim.keymap.set('n', '<leader>tf', ':NvimTreeFindFileToggle<CR>', {})

--vim.keymap.set('n', '<leader>w', 'ysie)a', { remap = true })
vim.keymap.set('n', '<leader>w', 'ysie)ax<LEFT><C-O>r<SPACE>', { remap = true })
vim.keymap.set('n', '<leader>W', 'ysif)a', { remap = true })
vim.keymap.set('n', '==', 'mzvaf=0<Esc>`z', { remap = true })
vim.keymap.set('x', 'p', 'pgvy', { remap = false })

vim.keymap.set("n", "<leader>nw", "<Plug>(neorg.telescope.switch_workspace)")
vim.keymap.set("n", "<leader>nf", "<Plug>(neorg.telescope.find_norg_files)")

vim.keymap.set("n", "<leader>gb", function() Snacks.gitbrowse() end, {})
vim.keymap.set("v", "<leader>gb", function() Snacks.gitbrowse() end, {})

vim.keymap.set('n', '<leader>yp', function()
  local path = vim.fn.expand('%:.')
  vim.fn.setreg('+', path)
  print('Copied: ' .. path)
end, { desc = 'Copy relative file path' })
