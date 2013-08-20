set autoindent
set smartindent
set cindent

set tabstop=4
set shiftwidth=4
set softtabstop=0

augroup set_indent
	autocmd!
	autocmd filetype coffee setlocal sw=2 sts=2 ts=2 et
augroup END
