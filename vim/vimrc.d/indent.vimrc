set autoindent
set smartindent
set cindent

set tabstop=4
set shiftwidth=4
set softtabstop=0

augroup set_indent
	autocmd!
	autocmd filetype coffee,javascript setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab
	autocmd filetype task   setlocal shiftwidth=2 softtabstop=0 tabstop=2 expandtab
augroup END
