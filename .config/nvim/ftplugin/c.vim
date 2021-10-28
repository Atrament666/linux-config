set number
nnoremap <F9> :w:make %<    
nnoremap <F33> :!clear > /dev/null;./%<
nnoremap Æ :%!astyle --mode=c --style=linux
packadd termdebug
map <F6> :Termdebug
