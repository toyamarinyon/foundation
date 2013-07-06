" Vimfier Setting

nnoremap <silent> ,h :VimFilerBufferDir <CR>

" configuration
let g:vimfiler_data_directory=expand($VIM_ROOT)
let s:bundle = neobundle#get("vimfiler")
function! s:bundle.hooks.on_source(bundle)
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_as_default_explorer = 1
endfunction
unlet s:bundle
