function! s:post()
	let entry = webapi#atom#newEntry()
	call entry.setTitle(GetTitle())
	call entry.setContentType('text/html')
	call entry.setContent(GetContent())
	echo entry
endfunction

let s:script_local_variables=[]
function! GetTitle()
	return input('タイトル： ')
endfunction

function! GetContent()
	return 'get content'
endfunction

" echo s:post()
