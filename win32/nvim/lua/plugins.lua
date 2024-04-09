local install_path = vim.fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
	vim.cmd "packadd packer.nvim"
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
augroup packer_user_config
autocmd!
autocmd BufWritePost init.lua source <afile> | PackerSync
augroup end
]]

-- Use a protected call so we don"t error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init {
	display = {
		open_fn = function()
			return require("packer.util").float { border = "rounded" }
		end,
	},
}

return packer.startup(function(use)
	use "wbthomason/packer.nvim"

    -- LSP and autocompletion config
	use "neovim/nvim-lspconfig"
	use "hrsh7th/cmp-nvim-lsp"
    use "neovim/nvim-lspconfig"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/nvim-cmp"
    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"

    -- Syntax
	use "leafgarland/typescript-vim"
	use "peitalin/vim-jsx-typescript"
	use "pangloss/vim-javascript"
	use "thesis/vim-solidity"
	use "elzr/vim-json"
	use "elixir-editors/vim-elixir"
	use "zah/nim.vim"
	use "tikhomirov/vim-glsl"
	use "cheap-glitch/vim-v"
	use "Tetralux/odin.vim"

    -- Utilities
	use "jiangmiao/auto-pairs"
	use "preservim/nerdtree"

    -- Seach tools
	use "junegunn/fzf"
	use "junegunn/fzf.vim"

    -- Themes
	use "hachy/eva01.vim"
	use "ghifarit53/tokyonight-vim"
	use "morhetz/gruvbox"
	use "skurob/robpur-vim"
	use "blueshirts/darcula"
	use "jnurmine/Zenburn"
	use "tomasiser/vim-code-dark"
	use "drsooch/gruber-darker-vim"
	use "sickill/vim-monokai"
	use "lifepillar/vim-solarized8"
	use "rhighs/vim-ariake-dark"
	use "rakr/vim-one"
end)
