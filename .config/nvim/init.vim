" Atramentovo ultimatni .vimrc
"

"plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-fugitive'
Plugin 'peterhoeg/vim-qml'
Plugin 'tpope/vim-vinegar'
Plugin 'neoclide/coc.nvim'
Plugin 'cpiger/neodebug'
Plugin 'igankevich/mesonic'
Plugin 'rust-lang/rust.vim'
Plugin 'timonv/vim-cargo'
Plugin 'yggdroot/indentline'
Plugin 'bfrg/vim-cpp-modern'
call vundle#end()

set nocompatible
set mouse=a
filetype plugin indent on 
filetype plugin on
filetype detect

"set invpaste
syntax enable
set history=1000
set tw=0
set shiftwidth=4
set tabstop=4
set expandtab
set autoindent 
set backspace=2 "nastaví backaspace na 'normální' chování
set wildmenu
let g:tex_flavor='pdflatex %'
let g:Tex_Folding=0
set grepprg=grep\ -nH\ $*
set iskeyword+=:
set ruler
set scrolloff=999
set completeopt-=preview
set clipboard=unnamedplus

set noshowmode
set encoding=utf-8

"set tags+=~/.vim/tags/cpp
"set tags+=~/.vim/tags/qt4
"set tags+=~/.vim/tags/clementine

"nastavení barev
hi Pmenu guibg=steelblue3 guifg=bg ctermfg=7 ctermbg=4 cterm=bold
hi PmenuSel guibg=fg guifg=bg gui=bold ctermfg=4 ctermbg=7 cterm=bold
hi Folded ctermfg=DarkGrey ctermbg=Black
hi Comment ctermfg=LightBlue
hi TabLineSel ctermbg=LightBlue ctermfg=Yellow
hi TabLine ctermfg=DarkGrey ctermfg=Yellow
hi LineNr ctermbg=darkgrey ctermfg=white
hi CursorLine cterm=NONE ctermbg=darkgrey

set cursorline


map  :tabnew 
map <C-Right> :tabnext  
map <C-Left> :tabprevious

imap  :tabnew 
imap <C-Right> :tabnext  
imap <C-Left> :tabprevious 

if has("autocmd")
	  autocmd BufReadPost *
	      \ if line("'\"") > 1 && line("'\"") <= line("$") |
	      \   exe "normal! g`\"" |
	      \ endif
endif

au BufRead /tmp/neomutt-* set tw=0
au BufRead /tmp/neomutt-* set spell
au BufRead /tmp/neomutt-* set spelllang=cs

"air-line configuration
let g:airline_powerline_fonts = 1

"ycm config
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"


nnoremap <F2> :w

"spelling
"set spelllang=cs
" pgdown next typo
"nnoremap <PageDown> ]s 
" pgup prev typo
"nnoremap <PageUp> [s
" home add to dict and jump to next
"nnoremap <Home> zg]s
" end list of options
"nnoremap <End> z=


function ToggleWrap()
  if &wrap
    echo "Wrap OFF"
    setlocal nowrap
    set virtualedit=all
    silent! nunmap <buffer> <Up>
    silent! nunmap <buffer> <Down>
    silent! nunmap <buffer> <Home>
    silent! nunmap <buffer> <End>
    silent! iunmap <buffer> <Up>
    silent! iunmap <buffer> <Down>
    silent! iunmap <buffer> <Home>
    silent! iunmap <buffer> <End>
  else
    echo "Wrap ON"
    setlocal wrap linebreak nolist
    set virtualedit=
    setlocal display+=lastline
    noremap  <buffer> <silent> <Up>   gk
    noremap  <buffer> <silent> <Down> gj
    noremap  <buffer> <silent> <Home> g<Home>
    noremap  <buffer> <silent> <End>  g<End>
    inoremap <buffer> <silent> <Up>   <C-o>gk
    inoremap <buffer> <silent> <Down> <C-o>gj
    inoremap <buffer> <silent> <Home> <C-o>g<Home>
    inoremap <buffer> <silent> <End>  <C-o>g<End>
  endif
endfunction
