inoremap <silent>, ,<Space>
inoremap <silent>jj <ESC>

" php
""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap <silent>thb ->
inoremap <silent><?? <?= ?><Left><Left>
inoremap <silent>$$ $this->
inoremap <silent>ppk $this->util->getPK('?')

inoremap <silent> <C-CR> <br>
inoremap <silent> <C-SPACE> &nbsp;
inoremap <expr> <C-R><C-R> expand('%:p')
inoremap <expr> :d strftime('%Y/%m/%d')

inoremap <C-e> <END>
inoremap <C-a> <HOME>
inoremap <C-h> <LEFT>
inoremap <C-j> <DOWN>
inoremap <C-k> <UP>
inoremap <C-l> <RIGHT>

nnoremap <silent> ;v :e ~/.vimrc<CR>
nnoremap <silent> ;s :source  ~/foundation/vim/vimrc.d/plugin_draft.vimrc<CR>
nnoremap <silent> <C-n> :<C-u>set number!<CR>
nnoremap <silent> <C-i> i<CR><ESC>
nnoremap <silent> m<space> :b#<CR>
nnoremap <silent> mw :set wrap!<CR>

nnoremap <silent> j gj
nnoremap <silent> k gk

vnoremap v $h

" join selected line remove space
vnoremap <silent> aj :s/\n\s*//g<CR>

" unite
""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap [unite] <Nop>
nmap <Space>u [unite]
nnoremap <silent> [unite]u :<C-u>Unite file_mru -winheight=5 -hide-source-names<CR>
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
nnoremap <silent> [unite]o :<C-u>Unite outline -vertical -winwidth=40<CR>
nnoremap <silent> [unite]b :<C-u>Unite bookmark -default-action=vimfiler -no-start-insert<CR>
nnoremap <silent> [unite]s :<C-u>Unite svn/status<CR>
nnoremap <silent> [unite]c :<C-u>Unite colorscheme -auto-preview<CR>
nnoremap <silent> [unite]p :<C-u>Unite ref/phpmanual -winheight=10 -hide-source-names<CR>
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir file -winheight=8<CR>

" VimFiler
""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> ,h :VimFilerBufferDir <CR>

" textmanip
""""""""""""""""""""""""""""""""""""""""""""""""""""
xmap <C-j> <Plug>(textmanip-move-down)
xmap <C-k> <Plug>(textmanip-move-up)
xmap <C-h> <Plug>(textmanip-move-left)
xmap <C-l> <Plug>(textmanip-move-right)
