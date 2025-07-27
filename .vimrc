set number
set numberwidth=2
set relativenumber
set tags=./tags;,tags;
set scrolloff=15
set smartindent

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ayu-theme/ayu-vim'
call plug#end()

colorscheme ayu
set termguicolors
let ayucolor="dark"

let mapleader = " "
nnoremap <leader><CR> :so ~/.vimrc<CR>
nnoremap <leader>pv :Vex<CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>f :Files<CR> 
nnoremap <leader>s :w<CR>
nnoremap <leader>q :wq<CR>
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprev<CR>
nnoremap <leader>c <C-w>w
nnoremap <leader>q :q<CR>
nnoremap <leader>t :term<CR>
"imap y zz
"imap z aa

set showcmd

