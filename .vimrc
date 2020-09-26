set rnu
syntax on

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

set noerrorbells
set expandtab
set swapfile
set incsearch
set smartindent
set smartcase

call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'vim-scripts/AutoComplPop'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
call plug#end()

colorscheme onedark

"java syntax checker(useless)
let g:syntastic_java_checkers = []
let g:EclimFileTypeValidate = 0

"nerdtree arrows and sets
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
map <C-n> :NERDTreeToggle<CR>
