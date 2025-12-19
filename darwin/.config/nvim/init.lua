require("plugins")
require("mason").setup()
require("lspconfig-setup")
require("mason-lspconfig").setup {
  ensure_installed = { "pyrefly" },
}

vim.api.nvim_create_autocmd({"FileType"}, {
  pattern = {"typescript", "javascript", "typescriptreact", "javascriptreact"},
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end
})

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true
})

vim.cmd [[ filetype plugin indent on ]]
-- show existing tab with 4 spaces width
vim.cmd [[ set tabstop=4 ]]
-- when indenting with '>', use 4 spaces width
vim.cmd [[ set shiftwidth=4 ]]
vim.cmd [[ syntax on ]]
vim.cmd [[ set rnu ]]
vim.cmd [[ set noerrorbells ]]
vim.cmd [[ set expandtab ]]
vim.cmd [[ set swapfile ]]
vim.cmd [[ set smartindent ]]
vim.cmd [[ set noerrorbells ]]
vim.cmd [[ set hlsearch ]]
vim.cmd [[ set ignorecase ]]
vim.cmd [[ set incsearch ]]
vim.cmd [[ set mouse=a ]]
vim.cmd [[ set completeopt-=preview ]]
vim.cmd [[ set nocompatible ]]
vim.cmd [[ set number ]]
vim.cmd [[ set autoread ]]
vim.cmd [[ set autowrite ]]
vim.cmd [[ set tw=140 ]]

vim.cmd[[ set termguicolors ]]
vim.cmd[[ set background=dark ]]
vim.cmd[[ colorscheme eva01 ]]

vim.cmd[[ map <C-n> :NERDTreeToggle<CR> ]]
