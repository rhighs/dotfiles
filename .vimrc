set rnu
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4

syntax on
syntax enable
set noerrorbells
set expandtab
set swapfile
set smartindent
set noerrorbells
set mouse=a
set completeopt-=preview

call plug#begin(expand('~/.vim/plugged'))
Plug 'morhetz/gruvbox'
Plug 'vim-scripts/AutoComplPop'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
Plug 'patstockwell/vim-monokai-tasty'

Plug 'pangloss/vim-javascript'
Plug 'elzr/vim-json'

"themes
Plug 'arcticicestudio/nord-vim'
call plug#end()

"needed to make nord-vim render properly
if (has("termguicolors"))
  set termguicolors
endif

colorscheme nord
"let g:vim_monokai_tasty_italic = 1                    " allow italics, set this before the colorscheme
"colorscheme vim-monokai-tasty                         " set the colorscheme

"nerdtree arrows and sets
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

"let g:ycm_show_diagnostics_ui = 1
"let g:ycm_enable_diagnostic_signs = 0 
"let g:ycm_enable_diagnostic_highlighting = 0

map <C-n> :NERDTreeToggle<CR>
