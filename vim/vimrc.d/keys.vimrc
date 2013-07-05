inoremap <silent>, ,<Space>
inoremap <silent>jj <ESC>
inoremap <silent>thb ->
inoremap <silent><?? <?php ;?><Left><Left><Left>
inoremap <silent>$$ $this->
inoremap <silent>ppk $this->util->getPK('?')
inoremap <silent> <C-CR> <br />
inoremap <silent> <C-SPACE> &nbsp;
inoremap <silent> <C-CR> <br />
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
nnoremap <silent> ;s :source  ~/.vimrc<CR>
nnoremap <silent> <C-m> :set number!<CR>
nnoremap <silent> <C-i> i<CR><ESC>
nnoremap <silent> m<space> :b#<CR>
nnoremap <silent> mw :set wrap!<CR>

nnoremap <silent> j gj
nnoremap <silent> k gk

vnoremap v $h

" unite
""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap [unite] <Nop>
nmap <Space>u [unite]
nnoremap <silent> [unite]u :Unite file_mru -winheight=5 -hide-source-names<CR>
nnoremap <silent> [unite]a :UniteBookmarkAdd<CR>
nnoremap <silent> [unite]o :Unite outline -vertical -winwidth=40<CR>
nnoremap <silent> [unite]b :Unite bookmark -default-action=vimfiler -no-start-insert<CR>
nnoremap <silent> [unite]s :Unite svn/status<CR>
nnoremap <silent> [unite]c :Unite colorscheme -auto-preview<CR>
nnoremap <silent> [unite]p :Unite ref/phpmanual -winheight=10 -hide-source-names<CR>

" VimFiler
""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> ,h :VimFilerBufferDir <CR>
