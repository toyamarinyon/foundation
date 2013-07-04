let g:neocomplcache_enable_at_startup = 1

let s:bundle = neobundle#get("neocomplcache")
function! s:bundle.hooks.on_source(bundle)
  imap <C-k> <Plug>(neocomplcache_snippets_expand)
endfunction
unlet s:bundle
