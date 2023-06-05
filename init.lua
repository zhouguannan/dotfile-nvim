vim.g.mapleader = " "
vim.g.localleader = " "
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require "options"

require("lazy").setup({
	"folke/lazy.nvim",
	"goolord/alpha-nvim",
	"folke/tokyonight.nvim",
	"kyazdani42/nvim-web-devicons",
    "nvim-lualine/lualine.nvim",
	"akinsho/bufferline.nvim",
    "nvim-tree/nvim-tree.lua",
    "ggandor/leap.nvim",
    "akinsho/toggleterm.nvim",
    {'nvim-telescope/telescope.nvim', tag = '0.1.1', dependencies = {'nvim-lua/plenary.nvim'}},
    "m4xshen/autoclose.nvim",
    'nvim-treesitter/nvim-treesitter',
    'norcalli/nvim-colorizer.lua',
    "lukas-reineke/indent-blankline.nvim",
    "mrjones2014/nvim-ts-rainbow",
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'numToStr/Comment.nvim',
    'RRethy/vim-illuminate',
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    'mhartington/formatter.nvim',
    "folke/trouble.nvim",
    "glepnir/lspsaga.nvim",
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    "onsails/lspkind.nvim",
    "folke/neodev.nvim",
    'nvim-telescope/telescope-project.nvim',
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = false }, 
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    'ldelossa/nvim-dap-projects',
    'ray-x/lsp_signature.nvim',
    "lambdalisue/suda.vim",
    "ahmedkhalf/project.nvim",
    'kevinhwang91/nvim-bqf',
    'kdheepak/lazygit.nvim',
    "kylechui/nvim-surround",
    "Pocco81/auto-save.nvim",
})
require "plug-setting"
require "lsp"
require "nvim-cmp"
require "dap-conf"
require "keybind"
