-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  -- Mason: installs LSP server binaries
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  -- nvim-lspconfig: provides default cmd/filetypes config per server
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason-org/mason.nvim" },
  },

  -- mason-lspconfig: bridges mason installs → vim.lsp.enable(), auto-installs servers
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = false,
    dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "rust_analyzer",
          "clangd",
          "pyrefly",
        },
        automatic_enable = true,
      })
    end,
  },

  -- Autocompletion — must load early so capabilities are ready when LSP starts
  { "hrsh7th/nvim-cmp",      lazy = false },
  { "hrsh7th/cmp-nvim-lsp",  lazy = false },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },

  -- Syntax
  { "tikhomirov/vim-glsl" },

  -- Utilities
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  { "preservim/nerdtree" },

  -- Search
  { "junegunn/fzf" },
  { "junegunn/fzf.vim" },

  -- Theme
  { "hachy/eva01.vim" },
})
