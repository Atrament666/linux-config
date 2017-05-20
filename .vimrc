" Atramentovo ultimatni .vimrc
"
set nocompatible
execute pathogen#infect()
call pathogen#helptags()
filetype plugin indent on 
set mouse=a

"set invpaste
syntax enable
set history=1000
set tw=0
set shiftwidth=2
set tabstop=2
set autoindent 
set backspace=2 "nastaví backaspace na 'normální' chování
set wildmenu
let g:tex_flavor='pdflatex %'
let g:Tex_Folding=0
set grepprg=grep\ -nH\ $*
set iskeyword+=:
set ruler

"nastavení barev
hi Pmenu guibg=steelblue3 guifg=bg ctermfg=7 ctermbg=4 cterm=bold
hi PmenuSel guibg=fg guifg=bg gui=bold ctermfg=4 ctermbg=7 cterm=bold
hi Folded ctermfg=DarkGrey ctermbg=Black
hi Comment ctermfg=LightBlue
hi TabLineSel ctermbg=LightBlue ctermfg=Yellow
hi TabLine ctermfg=DarkGrey

map  :tabnew 
map [1;5C :tabnext  
map [1;5D :tabprevious

imap  :tabnew 
imap [1;5C :tabnext  
imap [1;5D :tabprevious 

if has("autocmd")
	  autocmd BufReadPost *
	      \ if line("'\"") > 1 && line("'\"") <= line("$") |
	      \   exe "normal! g`\"" |
	      \ endif
endif

au BufRead /tmp/mutt-* set tw=0
au BufRead /tmp/mutt-* set spell
au BufRead /tmp/mutt-* set spelllang=cs

:map <F2> :w<cr>
:map <F9> :w<cr>:make<cr><cr>
:map <F3> :Explore
