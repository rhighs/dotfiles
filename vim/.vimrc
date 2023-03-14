filetype plugin indent on

" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4

syntax on

set rnu
set noerrorbells
set expandtab
set swapfile
set smartindent
set noerrorbells
set hlsearch
set ignorecase
set incsearch
set mouse=a
set completeopt-=preview
"set cursorline
set nocompatible
set number
set autoread
set autowrite
set tw=140

call plug#begin(expand('~/.vim/plugged'))
"languages and typing
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'pangloss/vim-javascript'
Plug 'thesis/vim-solidity'
Plug 'elzr/vim-json'
Plug 'elixir-editors/vim-elixir'
Plug 'zah/nim.vim'
Plug 'tikhomirov/vim-glsl'
Plug 'cheap-glitch/vim-v'

"util
Plug 'christoomey/vim-system-copy'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"auto-completers
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"themes
Plug 'wojciechkepka/vim-github-dark'
Plug 'ghifarit53/tokyonight-vim'
Plug 'morhetz/gruvbox'
Plug 'skurob/robpur-vim'
Plug 'blueshirts/darcula'
Plug 'jnurmine/Zenburn'
Plug 'tomasiser/vim-code-dark'
Plug 'drsooch/gruber-darker-vim'
Plug 'sickill/vim-monokai'
Plug 'lifepillar/vim-solarized8'
Plug 'rhighs/vim-ariake-dark'
Plug 'rakr/vim-one'
call plug#end()

set termguicolors
set background=dark
colorscheme ariake
"colorscheme one
"colorscheme darcula
"colorscheme robpur-mk2
"colorscheme GruberDarker
"highlight clear LineNr
"set t_Co=256
"set t_ut=
"let g:codedark_conservative = 1
"hi Normal ctermbg=16 guibg=#000000
"hi LineNr ctermbg=16 guibg=#000000

"nerdtree arrows and sets
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" =================== CPCV SETTIGNGS ========================
let g:system_copy#copy_command='xclip -sel clipboard'
let g:system_copy#paste_command='xclip -sel clipboard -o'
let g:system_copy_silent = 1

" =================== NERD TREE ============================
map <C-n> :NERDTreeToggle<CR>

" =================== Coc SETTIGNGS ========================
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<TAB>"

" =================== STATUS LINE ========================
set laststatus=2

source ~/.vim/plugged/robpur-vim/autoload/robpur-status.vim
