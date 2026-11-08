function! s:YankRef() range
  let l = getline(a:firstline, a:lastline)
  let fence = '```'
  while !empty(filter(copy(l), 'v:val =~# "^" . fence'))
    let fence .= '`'
  endwhile
  let rng = a:firstline == a:lastline ? a:firstline : a:firstline . '-' . a:lastline
  let out = fnamemodify(expand('%'), ':.') . ':' . rng . "\n" . fence . &filetype . "\n" . join(l, "\n") . "\n" . fence . "\n"
  call setreg('+', out)
  echo 'yanked ' . (a:lastline - a:firstline + 1) . ' lines with path'
endfunction

command! -range YankRef <line1>,<line2>call s:YankRef()
xnoremap <silent> <leader>y :YankRef<CR>
nnoremap <silent> <leader>y :YankRef<CR>
