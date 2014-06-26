set nocompatible
filetype off

""" Plugins

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" Text editing enhancements
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'

" Tools
Plugin 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'

" Look
Plugin 'chriskempson/base16-vim'
Plugin 'bling/vim-airline'

" SnipMate and its depedencies
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'

" Clojure
Plugin 'guns/vim-clojure-static'
Plugin 'tpope/vim-fireplace'
Plugin 'amdt/vim-niji'
Plugin 'vim-scripts/paredit.vim'

let g:clojure_fuzzy_indent_patterns = ['describe', 'it', '^doto', '^with', '^def', '^let']

" Other languages
Plugin 'vim-ruby/vim-ruby'
Plugin 'fsouza/go.vim'
Plugin 'tikhomirov/vim-glsl'
Plugin 'kchmck/vim-coffee-script'
Plugin 'ledger/vim-ledger'
Plugin 'tpope/vim-markdown'

" Tmux
"Plugin 'jpalardy/vim-slime'
"Plugin 'tpope/vim-dispatch'
"Plugin 'jgdavey/tslime.vim'
Plugin 'wellle/tmux-complete.vim'
Plugin 'christoomey/vim-tmux-navigator'

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

" Turn on syntax hilighting.
syntax enable
filetype plugin indent on

set autoread
set laststatus=2
set cursorline

" Hilight searches and do incremental searches. Also ignore case for searches.
set hlsearch
set incsearch
set ignorecase
set smartcase

set hidden      " Don't require saving before switching buffers
set showcmd     " Show command prefixes.
set wildmenu    " Menu of completions
set scrolloff=5 " Keep 5 lines of context when scrolling
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Files ignored when expanding wildcards. Also ignored by CtrlP.
set wildignore+=*.class,*/out/*,*/target/*
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

set textwidth=80
set shiftwidth=2
set tabstop=2

au FileType java setl sw=4 ts=4
au FileType sml setl sw=4 ts=4
au FileType lua setl sw=4 ts=4
au FileType go setl sw=4 ts=4

""" Bindings

" Set the leader
let mapleader = ","

" Turn off highlighted search
nnoremap <Leader>c :nohlsearch<CR>

" Fireplace
nnoremap <leader>rt :Require<CR>:RunTests<CR>

" Paredit
nnoremap <Leader>tp :call PareditToggle()<CR>

" NERDTree
nnoremap <leader>nt :NERDTreeToggle<CR>
