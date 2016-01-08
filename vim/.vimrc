set nocompatible
filetype off

""" Plugins

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" Text editing enhancements
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'junegunn/vim-pseudocl'
Plugin 'junegunn/vim-oblique'

" Tools
Plugin 'kien/ctrlp.vim'
let g:ctrlp_working_path_mode=0

Plugin 'naquad/ctrlp-digraphs.vim'
let g:ctrlp_extensions = ['tag', 'dir', 'undo', 'line', 'changes', 'digraphs']

Plugin 'mileszs/ack.vim'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-rsi'

Plugin 'aquach/vim-http-client'
Plugin 'vasconcelloslf/vim-interestingwords'
"Plugin 'KabbAmine/zeavim.vim'

Plugin 'scrooloose/syntastic'

let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_always_populate_loc_list = 1

Plugin 'manicolosi/taboo.vim'

let g:taboo_tab_format = "[%P%m] "

" Look and feel
Plugin 'chriskempson/base16-vim'
Plugin 'bling/vim-airline'
Plugin 'manicolosi/vim-airline-colornum'
"Plugin 'sjl/vitality.vim'

" Clojure
Plugin 'guns/vim-clojure-static'
Plugin 'tpope/vim-fireplace'
"Plugin 'venantius/vim-cljfmt'
"Plugin 'venantius/vim-eastwood'
Plugin 'losingkeys/vim-niji'
"Plugin 'vim-scripts/paredit.vim'
Plugin 'guns/vim-sexp'
Plugin 'tpope/vim-sexp-mappings-for-regular-people'

let g:clj_fmt_autosave = 0
let g:clojure_fuzzy_indent_patterns = ['^doto', '^with', '^def', '^let', 'go-loop', 'match', '^context', '^GET', '^PUT', '^POST', '^PATCH', '^DELETE', '^ANY']
let g:clojure_align_multiline_strings = 1

" Other languages
Plugin 'vim-ruby/vim-ruby'
Plugin 'fsouza/go.vim'
Plugin 'tikhomirov/vim-glsl'
Plugin 'kchmck/vim-coffee-script'
Plugin 'ledger/vim-ledger'
Plugin 'tpope/vim-markdown'

if has('nvim')
  Plugin 'neovim/node-host'
  "Plugin 'snoe/nvim-parinfer.js'
endif

let g:markdown_fenced_languages = [
      \ 'coffee',
      \ 'css',
      \ 'erb=eruby',
      \ 'javascript',
      \ 'js=javascript',
      \ 'json=javascript',
      \ 'ruby',
      \ 'sass',
      \ 'xml',
      \ 'html',
      \ 'clojure' ]

" Tmux
"Plugin 'jpalardy/vim-slime'
"Plugin 'tpope/vim-dispatch'
"Plugin 'jgdavey/tslime.vim'
Plugin 'wellle/tmux-complete.vim'
Plugin 'christoomey/vim-tmux-navigator'

if has('nvim')
  nmap <bs> :<c-u>TmuxNavigateLeft<cr>
endif

Plugin 'tmux-plugins/vim-tmux-focus-events'

au FocusLost * silent redraw!

call vundle#end()

""" Look and Feel

set background=dark
let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-default

let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='base16'

if has("gui_running")
  set guioptions-=T " Remove toolbar
  set guioptions-=m " Remove menu bar
  set guioptions-=r " Remove scroll bar
  set guioptions-=L " Remove scroll bar

  set guifont=Inconsolata-g\ 11

  " Highlight column 81 and 121 and up
  let &colorcolumn="81,".join(range(121,999),",")
endif

syntax enable
filetype plugin indent on

" Breaks color theme for CtrlP in airline...?
hi normal ctermbg=none

""" Options

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

set hidden      " Don't require saving before switching buffers
set showcmd     " Show command prefixes.
set wildmenu    " Menu of completions
set scrolloff=5 " Keep 5 lines of context when scrolling

set nobackup
set noswapfile

set undofile
set undodir=~/.vim/undo

" Files ignored when expanding wildcards. Also ignored by CtrlP.
set wildignore+=*.class
set wildignore+=*/out/*
set wildignore+=*/target/*
set wildmode=longest,full

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

au FileType java setl sw=4 ts=4
au FileType sml setl sw=4 ts=4
au FileType lua setl sw=4 ts=4
au FileType go setl sw=4 ts=4
au FileType coffee setl sw=2 ts=2

"autocmd BufWritePre * :%s/\s\+$//e " Auto-strip trailing whitespace on write
autocmd VimResized * :wincmd =
autocmd BufRead,BufNewFile *.cljx setfiletype clojure
autocmd BufRead,BufNewFile build.boot setfiletype clojure
autocmd FileType text setl formatoptions+=t

source $VIMRUNTIME/ftplugin/man.vim
autocmd FileType man setlocal nolist readonly nomodifiable

""" Maps and Commands

let mapleader = ","
let maplocalleader = ","

" General
nnoremap Y y$
nnoremap <leader>p ya(%a<CR><esc>p
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>
nmap <leader>tk ds"i:<ESC>
"nmap <leader>ts "adiwPbxcsw"
nmap <leader>pe :%s/, /\r/g<CR>:%s/} {/}\r{/g<CR>gg=G
nmap <leader>s mzgg/:require<CR>)i<CR><ESC>(jV)b:sort<CR>))bJ`z

" CtrlP
nmap <C-S-P> :CtrlPBuffer<CR>

" NERDTree
nmap <leader>nt :NERDTreeToggle<CR>

" Fireplace

"" Connecting
command! DroidConnect :Connect nrepl://localhost:9999
command! Figwheel :Piggieback! (do (require 'figwheel-sidecar.repl-api) (figwheel-sidecar.repl-api/cljs-repl))

nmap <leader>C :Connect<CR>1<CR>
nmap <leader>cd :DroidConnect<CR><CR>
nmap <leader>cb :Piggieback (adzerk.boot-cljs-repl/repl-env)<CR><CR>
nmap <leader>cf :Figwheel<CR><CR>

"" Evaluation
nmap <Leader>F <Plug>FireplacePrint<Plug>(sexp_outer_top_list)``
nmap <Leader>f <Plug>FireplacePrint<Plug>(sexp_outer_list)``
nmap <Leader>e <Plug>FireplacePrint<Plug>(sexp_inner_element)``
nmap <Leader>E :%Eval<CR>
