" unite setting

" configuration
let s:bundle = neobundle#get("unite.vim")
function! s:bundle.hooks.on_source(bundle)
  let g:unite_enable_start_insert = 1
  let g:unite_source_history_yank_enable = 1
endfunction
unlet s:bundle

" keymapping
nnoremap [unite] <Nop>
nmap <Space>u [unite]
nnoremap <silent> [unite]u :Unite file_mru -winheight=5 -hide-source-names<CR>
nnoremap <silent> [unite]a :UniteBookmarkAdd<CR>
nnoremap <silent> [unite]o :Unite outline -vertical -winwidth=40<CR>
nnoremap <silent> [unite]b :Unite bookmark -default-action=vimfiler -no-start-insert<CR>
nnoremap <silent> [unite]s :Unite svn/status<CR>
nnoremap <silent> [unite]c :Unite colorscheme<CR>
nnoremap <silent> [unite]p :Unite ref/phpmanual -winheight=10 -hide-source-names<CR>
