set nocompatible

" Set the leader
let mapleader = ","

syntax enable

colorscheme Tomorrow-Night-Mine

call pathogen#infect()

if has("gui_running")
  set guioptions-=T " Remove toolbar
  set guioptions-=m " Remove menu bar
  set guioptions-=r " Remove scroll bar
  set guioptions-=L " Remove scroll bar

  set guifont="Inconsolata 12"

  " Highlight column 81 and 121 and up
  let &colorcolumn="81,".join(range(121,999),",")
endif

set cursorline                       " Highlight current line

" Hilight searches and do incremental searches. Also ignore case for searches.
set hlsearch
set incsearch
set ignorecase
set smartcase

set hidden      " Don't require saving before switching buffers
set showcmd     " Show command prefixes.
set wildmenu    " Menu of completions
set scrolloff=5 " Keep 5 lines of context when scrolling
set autochdir   " Change to the directory of the file in a buffer
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Files ignored when expanding wildcards. Also ignored by CtrlP.
set wildignore+=*.class

set number
set cpoptions+=n " Wrapped text uses line number columns

set listchars=tab:→·,trail:·

" Turn on auto indenting.
set autoindent
set smartindent
set smarttab
set expandtab

set textwidth=80
set shiftwidth=2
set tabstop=2

" Turn on syntax hilighting.
filetype plugin indent on

au FileType java setl sw=4 ts=4
au FileType sml setl sw=4 ts=4

""" BINDINGS

" Toggle between line numbers, relative line numbers, and no line numbers
map <Leader>nn :set <c-r>={'00':'','01':'r','10':'nor'}[&rnu.&nu]<CR>nu<CR>
map <Leader>nl :set list!<CR>
" Turn off highlighted search
nmap <silent> <leader>nh :silent:nohlsearch<CR>

" Tab and Shift-Tab to switch buffers
nmap <TAB>   :bn<CR>
nmap <S-TAB> :bp<CR>

" NERDTree
nmap <leader>nt :NERDTreeToggle<CR>

" tslime
vmap <C-c><C-c> <Plug>SendSelectionToTmux
nmap <C-c><C-c> <Plug>NormalModeSendToTmux
nmap <C-c>r <Plug>SetTmuxVars

""" Plugin Settings

" VimClojure
let vimclojureRoot = $HOME."/.vim/bundle/vimclojure"
let vimclojure#HighlightBuiltins=1
let vimclojure#HighlightContrib=1
let vimclojure#DynamicHighlighting=1
let vimclojure#ParenRainbow=1
let vimclojure#FuzzyIndent=1
