let g:typer_speed    = 1
let g:typer_zz_count = 16

function! TyperLoop(file)
	let line_count = 0
	for line in readfile(a:file)
		let len = strlen(line)
		let i   = 0
		while i < len
			let c  = strpart(line, i, g:typer_speed)
			let i += g:typer_speed
			call getchar()
			execute "normal! GA".c
			redraw
		endwhile
		execute "normal! Go"
		call cursor(line('.')+1, 1)
		let line_count += 1
		if line_count > g:typer_zz_count
			let line_count = 0
			execute "normal! \zz"
		endif
		redraw
	endfor
endfunction

:command! -nargs=1 -complete=file Typer :call TyperLoop('<args>')

