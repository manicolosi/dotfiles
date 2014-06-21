set nocompatible
filetype off

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

let g:clojure_fuzzy_indent_patterns = ['describe', 'it', '^doto', '^with', '^def', '^let']

" Other languages
Plugin 'tikhomirov/vim-glsl'
Plugin 'fsouza/go.vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'ledger/vim-ledger'
Plugin 'tpope/vim-markdown'
Plugin 'kchmck/vim-coffee-script'

" Tmux
"Plugin 'jpalardy/vim-slime'
"Plugin 'tpope/vim-dispatch'
Plugin 'jgdavey/tslime.vim'
Plugin 'wellle/tmux-complete.vim'
Plugin 'christoomey/vim-tmux-navigator'

call vundle#end()

set background=dark
let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-default

let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='base16'

" Turn on syntax hilighting.
syntax enable
filetype plugin indent on

if has("gui_running")
  set guioptions-=T " Remove toolbar
  set guioptions-=m " Remove menu bar
  set guioptions-=r " Remove scroll bar
  set guioptions-=L " Remove scroll bar

  set guifont=Inconsolata-g\ 11

  " Highlight column 81 and 121 and up
  let &colorcolumn="81,".join(range(121,999),",")
endif

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
set wildignore+=*.class
set wildmode=longest,full

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

au FileType java setl sw=4 ts=4
au FileType sml setl sw=4 ts=4
au FileType lua setl sw=4 ts=4
au FileType go setl sw=4 ts=4

""" BINDINGS

" Set the leader
let mapleader = ","

" Toggle between line numbers, relative line numbers, and no line numbers
map <Leader>nn :set <c-r>={'00':'','01':'r','10':'nor'}[&rnu.&nu]<CR>nu<CR>
map <Leader>nl :set list!<CR>
" Turn off highlighted search
nnoremap <Leader>c :nohlsearch<CR>
nnoremap <silent> <C-l> :nohlsearch<CR><C-l>

" Tab and Shift-Tab to switch buffers
nmap <TAB>   :bn<CR>
nmap <S-TAB> :bp<CR>

" Easy window movement
"nnoremap <C-J> <C-W><C-J>
"nnoremap <C-K> <C-W><C-K>
"nnoremap <C-L> <C-W><C-L>
"nnoremap <C-H> <C-W><C-H>

" NERDTree
nmap <leader>nt :NERDTreeToggle<CR>

" vim-slime
let g:slime_target = "tmux"
