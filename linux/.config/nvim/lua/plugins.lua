local install_path = vim.fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
	vim.cmd "packadd packer.nvim"
end

-- autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
augroup packer_user_config
autocmd!
autocmd BufWritePost init.lua source <afile> | PackerSync
augroup end
]]

-- use a protected call so we don"t error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- have packer use a popup window
packer.init {
	display = {
		open_fn = function()
			return require("packer.util").float { border = "rounded" }
		end,
	},
}

return packer.startup(function(use)
	use "wbthomason/packer.nvim"

    -- lsp and autocompletion config
	use "neovim/nvim-lspconfig"
	use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/nvim-cmp"
    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"

    -- syntax
	use "leafgarland/typescript-vim"
	use "tikhomirov/vim-glsl"
	use "cheap-glitch/vim-v"

    -- utilities
	use "jiangmiao/auto-pairs"
	use "preservim/nerdtree"

    -- seach tools
	use "junegunn/fzf"
	use "junegunn/fzf.vim"

    -- themes
	use "hachy/eva01.vim"
end)
