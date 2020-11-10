set nu
syntax enable

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
set smartindent
set noerrorbells
set mouse=a
set completeopt-=preview

call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'vim-scripts/AutoComplPop'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
Plug 'patstockwell/vim-monokai-tasty'

Plug 'crusoexia/vim-monokai'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'styled-components/vim-styled-components'
Plug 'elzr/vim-json'
Plug 'jparise/vim-graphql'
call plug#end()

colorscheme monokai
highlight nonText ctermbg=NONE
"let g:vim_monokai_tasty_italic = 1                    " allow italics, set this before the colorscheme
"colorscheme vim-monokai-tasty                         " set the colorscheme

"java syntax checker(useless)
let g:syntastic_java_checkers = []
let g:EclimFileTypeValidate = 0

"nerdtree arrows and sets
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'


let g:ycm_show_diagnostics_ui = 1
let g:ycm_enable_diagnostic_signs = 0 
let g:ycm_enable_diagnostic_highlighting = 0



map <C-n> :NERDTreeToggle<CR>


