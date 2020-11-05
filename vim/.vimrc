set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'gmarik/Vundle.vim'

" Text editing enhancements
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'junegunn/vim-pseudocl'
Plug 'junegunn/vim-oblique'
Plug 'terryma/vim-multiple-cursors'

let g:multi_cursor_exit_from_insert_mode=0

" Tools

"Plug 'autozimu/LanguageClient-neovim', {
"    \ 'branch': 'next',
"    \ 'do': 'bash install.sh',
"    \ }
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}


Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-rsi'

Plug 'aquach/vim-http-client'

Plug 'scrooloose/syntastic'
Plug 'aclaimant/syntastic-joker'

let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_clojure_checkers = ['joker']

Plug 'manicolosi/taboo.vim'

let g:taboo_tab_format = " %N. %P%m "

" Look and feel
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'manicolosi/vim-airline-colornum'

" Clojure
Plug 'guns/vim-clojure-static'
Plug 'tpope/vim-fireplace'
Plug 'losingkeys/vim-niji'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'

let g:clj_fmt_autosave = 0
let g:clojure_fuzzy_indent_patterns = ['^doto', '^with', '^def', '^let', 'go-loop', 'match', '^context', '^GET', '^PUT', '^POST', '^PATCH', '^DELETE', '^ANY', 'this-as', '^are', '^reg-', 'fdef', '^dofor']
let g:clojure_align_multiline_strings = 1

" Other languages
Plug 'vim-ruby/vim-ruby'
Plug 'fsouza/go.vim'
Plug 'tikhomirov/vim-glsl'
Plug 'kchmck/vim-coffee-script'
Plug 'ledger/vim-ledger'
"Plug 'tpope/vim-markdown'
Plug 'plasticboy/vim-markdown'

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
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'

let g:tmux_navigator_disable_when_zoomed = 1

call plug#end()

au FocusLost * silent redraw!

""" Look and Feel

if filereadable(expand("~/.vim_theme"))
  let base16colorspace=256
  source ~/.vim_theme
endif

highlight Pmenu ctermbg=236

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
"hi normal ctermbg=none

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

" Files ignored when expanding wildcards. Also ignored by CtrlP.
set wildignore+=*.class
set wildignore+=*/out/*
set wildignore+=*/app.out/*
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

set signcolumn=yes

"set spell spelllang=en_us

au FileType java setl sw=4 ts=4
au FileType sml setl sw=4 ts=4
au FileType lua setl sw=4 ts=4
au FileType go setl sw=4 ts=4
au FileType coffee setl sw=2 ts=2
au FileType scss setl iskeyword+=-

"autocmd BufWritePre * :%s/\s\+$//e " Auto-strip trailing whitespace on write
autocmd VimResized * :wincmd =
autocmd BufRead,BufNewFile *.cljx setfiletype clojure
autocmd BufRead,BufNewFile build.boot setfiletype clojure
autocmd BufRead,BufNewFile .joker setfiletype clojure
autocmd FileType text setl formatoptions+=t

autocmd FileType man setlocal nolist readonly nomodifiable

autocmd CursorHold * silent call CocAction('highlight')

""" Maps and Commands

let mapleader = ","
let maplocalleader = ","

nnoremap Y y$

" Copy sexp to next line
nnoremap <leader>p ya(%a<CR><esc>p

" Split line at cursor
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>

" Make pprint even prettier
nmap <leader>pe :%s/, /\r/g<CR>:%s/} {/}\r{/g<CR>gg=G

" Keyword <-> string
"nmap <leader>tk ds"i:<ESC>
"nmap <leader>ts "adiwPbxcsw"

" Sort namespaces in (:require)
function! CljSortRequireFn(find)
  let l:initialLine = line(".")
  let l:initialCol = col(".")
  exec "keepjumps normal gg"
  exe "keepjumps /". a:find ."$"
  let l:startLine = line(".") + 1
  if l:startLine != 2
    exe "keepjumps normal ^%"
    keepjumps let l:endLine = line(".")
    exe "keepjumps normal i\<CR>\<ESC>"
    let l:closingLine = l:endLine + 1
    exe l:startLine.",".l:endLine."sort"
    exe "keepjumps normal ".l:closingLine."gg"
    exe "keepjumps normal kJ"
  endif
  call cursor(l:initialLine, l:initialCol)
endfunction

command! -nargs=1 CljSortRequire call CljSortRequireFn(<q-args>)
nmap <silent> <leader>s :CljSortRequire :require<CR>
nmap <silent> <leader>m :CljSortRequire :require-macros<CR>

" NERDTree
nmap <leader>nt :NERDTreeToggle<CR>

" Fireplace

"" Connecting
command! DroidConnect :Connect nrepl://localhost:9999
command! Figwheel :Piggieback! (do (require 'figwheel-sidecar.repl-api) (figwheel-sidecar.repl-api/cljs-repl))

function! TabLcd(dir)
  tabnew
  exec "lcd " . a:dir
endfunction

command! -nargs=1 -complete=dir TL call TabLcd(<q-args>)

nmap <leader>C :Connect<CR>1<CR>
nmap <leader>cd :DroidConnect<CR><CR>
nmap <leader>cb :Piggieback (adzerk.boot-cljs-repl/repl-env)<CR><CR>
nmap <leader>cf :Figwheel<CR><CR>

"" Evaluation
nmap <Leader>F <Plug>FireplacePrint<Plug>(sexp_outer_top_list)``
nmap <Leader>f <Plug>FireplacePrint<Plug>(sexp_outer_list)``
nmap <Leader>e <Plug>FireplacePrint<Plug>(sexp_inner_element)``
nmap <Leader>E :%Eval<CR>
nmap <Leader>R cqp(require 'clojure.tools.namespace.repl) (clojure.tools.namespace.repl/refresh)<CR>

" Tab swtiching
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<CR>

au TabLeave * let g:lasttab = tabpagenr()
" Go to last active tab
nnoremap <silent> <leader>` :exe "tabn ".g:lasttab<CR>
vnoremap <silent> <leader>` :exe "tabn ".g:lasttab<CR>

" Ag
"
if executable('ag')
  let g:ackprg = 'ag --vimgrep --path-to-ignore=./.ignore'
endif


" FZF
nmap <silent> <C-n><C-p> :GFiles --exclude-standard --cached --others<CR>
nmap <silent> <C-n><C-b> :Buffers<CR>
nmap <silent> <C-n><C-f> :Files<CR>

nnoremap <leader>a :Ack!<Space>
nmap <leader>k :Ack! "\b<cword>\b" <CR>

" COC
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <leader>u <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
command! -nargs=0 Format :call CocAction('format')

inoremap <silent><expr> <c-space> coc#refresh()
nmap <silent> [l <Plug>(coc-diagnostic-prev)
nmap <silent> ]l <Plug>(coc-diagnostic-next)
nmap <silent> [w :CocPrev<cr>
nmap <silent> ]w :CocNext<cr>
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! Expand(exp) abort
    let l:result = expand(a:exp)
    return l:result ==# '' ? '' : "file://" . l:result
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
vmap <leader>crf <Plug>(coc-format-selected)
nmap <leader>crf <Plug>(coc-format-selected)

nnoremap <silent> crcc :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'cycle-coll', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crcp :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'cycle-privacy', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crth :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-first', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crtt :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-last', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crtf :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-first-all', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crtl :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'thread-last-all', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> cruw :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'unwind-thread', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crua :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'unwind-all', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crml :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'move-to-let', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1, input('Binding name: ')]})<CR>
nnoremap <silent> cril :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'introduce-let', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1, input('Binding name: ')]})<CR>
nnoremap <silent> crel :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'expand-let', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> cram :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'add-missing-libspec', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> crcn :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'clean-ns', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1]})<CR>
nnoremap <silent> cref :call CocRequest('clojure-lsp', 'workspace/executeCommand', {'command': 'extract-function', 'arguments': [Expand('%:p'), line('.') - 1, col('.') - 1, input('Function name: ')]})<CR>
"inoremap <silent><expr> <c-m> coc#refresh()

nnoremap <silent><space>s  :<C-u>CocList -I symbols<cr>

vmap <leader>= <Plug>(coc-format-selected)
nmap <leader>= <Plug>(coc-format-selected)

function! SynGroup()
  let l:s = synID(line('.'), col('.'), 1)
  echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

hi clear SpellBad
hi SpellBad cterm=underline,bold

hi clear CocHighlightText
hi CocHighlightText ctermbg=white ctermfg=black
