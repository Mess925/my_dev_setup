-- Disable Treesitter completely to avoid errors
vim.g.loaded_matchit = 1

-- Basic settings
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.relativenumber = true
vim.opt.scrolloff = 15
vim.opt.smartindent = true
vim.opt.showcmd = true
vim.opt.termguicolors = true
vim.opt.tags = "./tags;,tags;"

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- User variables
vim.g.user42 = 'hthant'
vim.g.mail42 = 'hthant@student.42.fr'

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Minimal plugin setup
require("lazy").setup({
	-- FZF for fuzzy finding
  {
    'junegunn/fzf',
    build = function() vim.fn['fzf#install']() end,
  },
  {
    'junegunn/fzf.vim',
    dependencies = { 'junegunn/fzf' }
  },
  
  -- Ayu colorscheme
  {
    'ayu-theme/ayu-vim',
    config = function()
      vim.g.ayucolor = "dark"
      vim.cmd('colorscheme ayu')
    end
  },
  
  -- Auto pairs
  { 'jiangmiao/auto-pairs' },
  
  -- Comments
  { 'tomtom/tcomment_vim' },
  
  -- Coc nvim 
  { 'neoclide/coc.nvim', branch = 'release', config = function()
	  vim.g.coc_global_extensions = {
		  'coc-clangd',
		  'coc-json',
	  }
  end
  },
  
  -- 42 Header plugin
  {
    'Diogo-ss/42-header.nvim',
    cmd = { 'Stdheader' },
    opts = {
      default_map = false,
      auto_update = true,
      user = 'hthant',
      mail = 'hthant@student.42.fr',
    },
    config = function(_, opts)
      require('42header').setup(opts)
    end,
  },
  
  -- Treesitter plugin (add this block)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "c", "vimdoc", "query" },
        highlight = { enable = true },
      })
    end,
  },
})

-- Key mappings
local keymap = vim.keymap.set

-- Reload config
keymap('n', '<leader><CR>', ':source ~/.config/nvim/init.lua<CR>')

-- File navigation
keymap('n', '<leader>pv', ':Vex<CR>')
keymap('n', '<C-p>', ':GFiles<CR>')
keymap('n', '<leader>f', ':Files<CR>')
keymap('n', '<leader>d', ':Ex<CR>')

-- File operations
keymap('n', '<leader>s', ':w<CR>')
keymap('n', '<leader>q', ':q<CR>')

-- Quickfix navigation
keymap('n', '<C-j>', ':cnext<CR>')
keymap('n', '<C-k>', ':cprev<CR>')

-- Window navigation
keymap('n', '<leader>c', '<C-w>w')

-- Terminal
keymap('n', '<leader>t', ':term<CR>')

-- Comments
keymap('n', '<leader>/', ':TComment<CR>')

-- Header (42header plugin)
keymap('n', '<leader>h', ':Stdheader<CR>')

-- Buffer navigation
keymap('n', '<leader>b', ':bp<CR>')

-- CoC key mappings
-- Use tab for trigger completion
keymap('i', '<TAB>', 'pumvisible() ? "\\<C-n>" : "\\<TAB>"', { expr = true })
keymap('i', '<S-TAB>', 'pumvisible() ? "\\<C-p>" : "\\<C-h>"', { expr = true })

-- Use <cr> to confirm completion
keymap('i', '<CR>', 'pumvisible() ? coc#_select_confirm() : "\\<C-g>u\\<CR>\\<c-r>=coc#on_enter()\\<CR>"', { expr = true })

-- GoTo code navigation
keymap('n', 'gd', '<Plug>(coc-definition)', { silent = true })
keymap('n', 'gy', '<Plug>(coc-type-definition)', { silent = true })
keymap('n', 'gi', '<Plug>(coc-implementation)', { silent = true })
keymap('n', 'gr', '<Plug>(coc-references)', { silent = true })

-- Show documentation
keymap('n', 'K', ':call CocAction("doHover")<CR>', { silent = true })

-- Show function signature
keymap('i', '<C-k>', '<Cmd>call CocActionAsync("showSignatureHelp")<CR>', { silent = true })
