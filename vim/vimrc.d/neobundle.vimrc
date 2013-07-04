if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Recommended to install
" After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'Shougo/vimproc'

" unite
NeoBundleLazy 'Shougo/unite.vim', {
\ 'autoload' : {
\   'commands' : ["Unite"]
\ }
\}
NeoBundleLazy 'h1mesuke/unite-outline', {
\ 'autoload' : {
\   'unite_sources' : "outline"
\ }
\}
NeoBundleLazy 'kmnk/vim-unite-svn', {
\ 'autoload' : {
\   'unite_sources' : "svn"
\ }
\}
NeoBundleLazy 'ujihisa/unite-colorscheme',  { 
\ 'autoload' : {
\ '  unite_sources' : 'colorscheme', 
\ }
\}

" Vimfiler
NeoBundleLazy 'Shougo/vimfiler', {
\ 'depends' : ["Shougo/unite.vim"],
\ 'autoload' : {
\   'commands' : ["VimFiler","VimFilerBufferDir"]
\ }
\}

" Vimshell
NeoBundleLazy 'Shougo/vimshell'

" neocomplecache
NeoBundle 'Shougo/neocomplcache'
" neosnippet
NeoBundle 'Shougo/neosnippet'

" zencoding
NeoBundle 'mattn/zencoding-vim', {
\ 'autoload' : {
\   'filetypes' : ["html","htm","erb","haml","php","cfm"]
\ }
\}

" yuroyoro256
NeoBundle 'yuroyoro/yuroyoro256.vim'

filetype plugin indent on     " Required!

" Installation check.
NeoBundleCheck
