local status, packer = pcall(require, 'packer')
if (not status) then
    print("Packer is not installed")
    return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
    use 'wbthomason/packer.nvim'

    -- Visual 
    use 'folke/tokyonight.nvim' -- theme
    use { "catppuccin/nvim", as = "catppuccin" }
    use 'hoob3rt/lualine.nvim' -- statusline
    use 'onsails/lspkind-nvim' -- icons for LSP completion
    use 'kyazdani42/nvim-web-devicons' -- icons for files in telescope
    use 'lewis6991/gitsigns.nvim' -- git change indicators

    -- Lsp and Completion
    use 'neovim/nvim-lspconfig'
    use 'L3MON4D3/LuaSnip'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/nvim-cmp'
    use({'scalameta/nvim-metals', requires = { "nvim-lua/plenary.nvim" }})

    -- Formatting
    use 'sbdchd/neoformat'

    -- DAP
    use 'mfussenegger/nvim-dap'
    use 'mfussenegger/nvim-dap-python'

    -- Auto-install LSP-servers
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'

    -- Telescope
    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/popup.nvim'
    use 'nvim-telescope/telescope.nvim'

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }
    use 'nvim-treesitter/nvim-treesitter-textobjects'

    -- Tim Pope
    use 'tpope/vim-surround'
    use 'tpope/vim-vinegar'
    use 'tpope/vim-commentary'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-sleuth'
end)
