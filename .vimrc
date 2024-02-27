" My slightly better .vimrc
"
" Now with 99% less suck.

set nocompatible
filetype plugin indent on
syntax on

" Plugins ------------- {{{
call plug#begin('~/.local/share/vim/site/plugged')
Plug 'tinted-theming/base16-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vadimr/bclose.vim'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
call plug#end()
" }}}
