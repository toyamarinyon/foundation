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
""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundleLazy 'Shougo/unite.vim', {
\ 'autoload' : {
\   'commands' : ["Unite"]
\ }
\}
let s:bundle = neobundle#get("unite.vim")
function! s:bundle.hooks.on_source(bundle)
  let g:unite_enable_start_insert = 1
  let g:unite_source_history_yank_enable = 1
endfunction
unlet s:bundle

" unite-outline
NeoBundleLazy 'h1mesuke/unite-outline', {
\ 'autoload' : {
\   'unite_sources' : "outline"
\ }
\}
" unite-svn
NeoBundleLazy 'kmnk/vim-unite-svn', {
\ 'autoload' : {
\   'unite_sources' : "svn/status"
\ }
\}
" unite-colorscheme
NeoBundleLazy 'ujihisa/unite-colorscheme',  { 
\ 'autoload' : {
\ 'unite_sources' : 'colorscheme', 
\ }
\}

" Vimfiler
""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundleLazy 'Shougo/vimfiler', {
\ 'depends' : ["Shougo/unite.vim"],
\ 'autoload' : {
\   'commands' : ["VimFiler","VimFilerBufferDir"]
\ }
\}
let s:bundle = neobundle#get("vimfiler")
function! s:bundle.hooks.on_source(bundle)
	let g:vimfiler_safe_mode_by_default = 0
	let g:vimfiler_as_default_explorer = 1
endfunction
unlet s:bundle

" Vimshell
""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundleLazy 'Shougo/vimshell'

" neocomplecache
""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'Shougo/neocomplcache'
let g:neocomplcache_enable_at_startup = 1

" neosnippet
""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'Shougo/neosnippet'

" html5
""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundleLazy 'othree/html5.vim', {
\ 'autoload' : {
\   'filetypes' : ["html","htm","erb","haml","php","cfm","slim"]
\ }
\}
" zencoding
""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundleLazy 'mattn/zencoding-vim', {
\ 'autoload' : {
\   'filetypes' : ["html","htm","erb","haml","php","cfm","slim"]
\ }
\}

" Align
""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'Align'

" silm
""""""""""""""""""""""""""""""""""""""""""""""""""""
NeoBundle 'slim-template/vim-slim'

" yuroyoro256
NeoBundle 'yuroyoro/yuroyoro256.vim'

filetype plugin indent on     " Required!

" Installation check.
NeoBundleCheck
