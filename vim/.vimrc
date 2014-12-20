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
let g:ctrlp_working_path_mode=0

Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'

" Look
Plugin 'chriskempson/base16-vim'
Plugin 'bling/vim-airline'

" Clojure
Plugin 'guns/vim-clojure-static'
Plugin 'tpope/vim-fireplace'
Plugin 'amdt/vim-niji'
"Plugin 'vim-scripts/paredit.vim'
Plugin 'guns/vim-sexp'
Plugin 'tpope/vim-sexp-mappings-for-regular-people'

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
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

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

autocmd BufWritePre * :%s/\s\+$//e " Auto-strip trailing whitespace on write
autocmd VimResized * :wincmd =

""" Maps and Commands

let mapleader = ","
let maplocalleader = ","

nnoremap Y y$

" CtrlP
nnoremap <leader>p :CtrlPBuffer<CR>

" Fireplace
command! DroidConnect Connect nrepl://localhost:9999
command! SimpleBrepl Piggieback (weasel.repl.websocket/repl-env :ip "0.0.0.0" :port 9001)

nmap <Leader>F <Plug>FireplacePrint<Plug>(sexp_outer_top_list)
nmap <Leader>f <Plug>FireplacePrint<Plug>(sexp_outer_list)
nmap <Leader>e <Plug>FireplacePrint<Plug>(sexp_inner_element)

nnoremap <leader>C :Connect<CR>1<CR><CR>
nnoremap <leader>cd :DroidConnect<CR><CR>
nnoremap <leader>cb :SimpleBrepl<CR><CR>
nnoremap <leader>ea :%Eval<CR>

" NERDTree
nnoremap <leader>nt :NERDTreeToggle<CR>
