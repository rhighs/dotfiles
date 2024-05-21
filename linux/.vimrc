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
Plug 'Tetralux/odin.vim'

"util
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"auto-completers
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"themes
Plug 'hachy/eva01.vim', { 'branch': 'main' }
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
colorscheme eva01
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

" https://github.com/neoclide/coc.nvim#example-vim-configuration
inoremap <silent><expr> <c-space> coc#refresh()

" gd - go to definition of word under cursor
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)

" gi - go to implementation
nmap <silent> gi <Plug>(coc-implementation)

" gr - find references
nmap <silent> gr <Plug>(coc-references)

" gh - get hint on whatever's under the cursor
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> gh :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

nnoremap <silent> <leader>co  :<C-u>CocList outline<cr>
nnoremap <silent> <leader>cs  :<C-u>CocList -I symbols<cr>

" List errors
nnoremap <silent> <leader>cl  :<C-u>CocList locationlist<cr>

" list commands available in tsserver (and others)
nnoremap <silent> <leader>cc  :<C-u>CocList commands<cr>

" restart when tsserver gets wonky
nnoremap <silent> <leader>cR  :<C-u>CocRestart<CR>

" view all errors
nnoremap <silent> <leader>cl  :<C-u>CocList locationlist<CR>

" manage extensions
nnoremap <silent> <leader>cx  :<C-u>CocList extensions<cr>

" rename the current word in the cursor
nmap <leader>cr  <Plug>(coc-rename)
nmap <leader>cf  <Plug>(coc-format-selected)
vmap <leader>cf  <Plug>(coc-format-selected)

" run code actions
vmap <leader>ca  <Plug>(coc-codeaction-selected)
nmap <leader>ca  <Plug>(coc-codeaction-selected)

" =================== CUSTOM MAPPINGS ========================
"map <esc> :noh <CR>

" =================== STATUS LINE ========================
set laststatus=2
 
source ~/.vim/plugged/robpur-vim/autoload/robpur-status.vim
