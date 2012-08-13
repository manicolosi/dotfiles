set nocompatible

" Set the leader
let mapleader = ","

" Set up the GUI.
set guioptions-=T " Remove toolbar
set guioptions-=m " Remove menu bar
set guioptions-=r " Remove scroll bar
set guioptions-=L " Remove scroll bar

syntax enable
set background=dark
colorscheme Tomorrow-Night

if has("gui_running")
  "set lines=50 columns=120
endif

set guifont=inconsolata\ 12

" Hilight searches and do incremental searches. Also ignore case for searches.
set hlsearch
set incsearch
set ignorecase
set smartcase

nmap <silent> <leader>n :silent:nohlsearch<CR>

" Tab and Shift-Tab to switch buffer
nmap <TAB>   :bn<CR>
nmap <S-TAB> :bp<CR>

call pathogen#infect()

set hidden      " Don't require saving before switching buffers
set showcmd     " Show command prefixes.
set wildmenu    " Menu of completions
set scrolloff=5 " Keep 5 lines of context when scrolling
set autochdir   " Change to the directory of the file in a buffer
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

set number
set cpoptions+=n " Wrapped text uses line number columns
map <Leader>nn :set <c-r>={'00':'','01':'r','10':'nor'}[&rnu.&nu]<CR>nu<CR>
highlight CursorLineNr guifg=#666666

set cursorline
highlight CursorLine guibg=#202223

" Turn on auto indenting.
set autoindent
set smartindent
set smarttab
set expandtab

set textwidth=78

set tabstop=2 shiftwidth=2

" Turn on syntax hilighting.
filetype plugin indent on

"au FileType ruby setl tabstop=2 shiftwidth=2

" tslime
vmap <C-c><C-c> <Plug>SendSelectToTmux
nmap <C-c><C-c> <Plug>NormalModeSendToTmux
nmap <C-c>r     <Plug>SetTmuxVars

" VimClojure
let vimclojureRoot = $HOME."/.vim/bundle/vimclojure-2.3.0"
let vimclojure#HighlightBuiltins=1
let vimclojure#HighlightContrib=1
let vimclojure#DynamicHighlighting=1
let vimclojure#ParenRainbow=1
let vimclojure#FuzzyIndent=1
