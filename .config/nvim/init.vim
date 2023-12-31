set relativenumber
set nu rnu
set scrolloff=99999
set nowrap
set clipboard+=unnamedplus
set list
set colorcolumn=80,130
set cursorline
set signcolumn=yes
set signcolumn=number
set nofixendofline
nnoremap <M-w> :bd<CR>:q<CR>
 
nnoremap <C-w> :bd<CR>:q<CR>
"r Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

Plug 'navarasu/onedark.nvim'
Plug 'ThePrimeagen/vim-be-good'
Plug 'mbbill/undotree'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }
Plug 'ThePrimeagen/harpoon', { 'branch': 'harpoon2' }
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
"Plug 'zbirenbaum/copilot.lua'
"Plug 'zbirenbaum/copilot-cmp'
Plug 'github/copilot.vim'
Plug 'nvim-lualine/lualine.nvim'
" If you want to have icons in your statusline choose one of these
Plug 'nvim-tree/nvim-web-devicons'

call plug#end()
