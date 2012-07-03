"
" Native Vim Color Scheme
" =======================
"
" author:   Armin Ronacher <armin.ronacher@active-4.com>
"
set background=dark

hi clear
if exists("syntax_on")
    syntax reset
endif

let colors_name = "native"

" Default Colors
hi Normal       guifg=#AAAAAA guibg=#181818
hi NonText      guifg=#444444 guibg=#181818
hi Cursor       guibg=white
hi CursorLine   guibg=#080808
hi Visual       guibg=#3677a9 guifg=#eeeeec

"Menus
hi Pmenu        guibg=#3677a9 guifg=#eeeeec
hi PmenuSel     guibg=#eeeeec guifg=#3677a9
hi pMenuSbar    guibg=#4687b9
hi pMenuThumb    guibg=#eeeeec guifg=#266789

" Search
hi Search	    guibg=#edd400 guifg=black

" Window Elements
hi StatusLine   guifg=#eeeeec guibg=#2e3436 gui=bold
hi StatusLineNC guifg=#2e3436 guibg=#babdb6
hi VertSplit    guifg=#2e3436 guibg=#2e3436
hi Folded       guifg=#111111 guibg=#8090a0
hi LineNr       guifg=#666666 guibg=#181818

" Specials
hi Todo         guifg=#e50808 guibg=#520000 gui=bold
hi Title        guifg=#ffffff gui=bold
hi Delimiter    guifg=#666666

" Syntax
hi Number       guifg=#3677a9
hi String       guifg=#edd400
hi Statement    guifg=#6ab825 gui=bold
hi Function     guifg=#447fcf
hi PreProc      guifg=#cd2828 gui=bold
hi Comment      guifg=#666666 gui=italic
hi Type         guifg=#bbbbbb gui=bold

