set relativenumber
set nu rnu
set scrolloff=99999
set nowrap
set clipboard+=unnamedplus
set list
set colorcolumn=80,130
set cursorline
" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

Plug 'navarasu/onedark.nvim'
Plug 'ThePrimeagen/vim-be-good'
Plug 'mbbill/undotree'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }
Plug 'ThePrimeagen/harpoon', { 'branch': 'harpoon2' }

" or                                , { 'branch': '0.1.x' }"

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
