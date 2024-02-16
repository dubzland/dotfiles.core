" My slightly better .vimrc
"
" Now with 99% less suck.

set nocompatible
filetype plugin indent on
syntax on

" Plugins ------------- {{{
call plug#begin('~/.vim/plugged')
Plug 'Konfekt/FastFold'
Plug 'scrooloose/nerdtree'
Plug 'tinted-theming/base16-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vadimr/bclose.vim'
call plug#end()
" }}}

" Options ------------- {{{
set encoding=utf-8
set modeline
set modelines=5
set autoindent
set showmode
set showcmd
set visualbell
set ttyfast
set ruler
set backspace=indent,eol,start
set number
set norelativenumber
set laststatus=2
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault

set cursorline
set cursorcolumn

set scrolloff=4
set sidescroll=1
set sidescrolloff=10

set virtualedit+=block

set foldmethod=marker
" set history=1000
set undofile
set undoreload=10000
set list
set listchars=tab:␉\ ,eol:¬,precedes:«,extends:»
set lazyredraw
set matchtime=5
set showbreak=+++\ 
set splitbelow
set splitright
set autoread
set shiftround
set title
set linebreak
set colorcolumn=+1
set re=0

" Wildmenu stuffs {{{
set wildmenu
set wildmode=list:longest
set wildignore+=.hg,.git,.svn
set wildignore+=*.aux,*.out,*.toc
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.o,*.obj,*.exe,*.dll,*.so,*.manifest
set wildignore+=*.sw?
set wildignore+=*.DS_Store
" }}}

" Tabs/Spaces/Wrapping {{{
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab
set wrap
set textwidth=80
set cindent
set smarttab
set omnifunc=syntaxcomplete#Complete
" }}}

" Formatting ---------- {{{
set statusline=[%n]\ %f\ [%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%{fugitive#statusline()}%=%c,%l/%L\ %P

augroup cursor_line
	au!
	au WinLeave,InsertEnter * set nocursorline nocursorcolumn
	au WinEnter,InsertLeave * set cursorline cursorcolumn
augroup END
" }}}

set mouse+=a
if &term =~ '^screen'
	if !has('nvim')
		set ttymouse=xterm2
	endif
endif

if has('conceal')
	set conceallevel=2 concealcursor=niv
endif
" }}}

autocmd QuickFixCmdPost [^l]* cwindow

" Bindings ------------ {{{
let mapleader = ","
let g:mapleader = ","

" Move between splits
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
if has('nvim')
	noremap <BS> <C-w>h
endif

map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
nmap <F3> :NERDTreeToggle<CR>
nnoremap <leader>n :NERDTreeFocus<CR>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Leaders {{{
noremap <silent> <leader><space> :noh<CR>:call clearmatches()<CR>
noremap <leader>q :Bclose<CR>
noremap <leader>c :cclose<CR>
noremap <Leader>d :filetype detect<CR>
" }}}

nnoremap <C-W>M <C-W>\|<C-W>_
nnoremap <C-W>m <C-W>=
" }}}

" Searching and cursor movement{{{
nnoremap / /\v
vnoremap / /\v
" }}}

" Colors -------------- {{{
set termguicolors
if exists('$BASE16_THEME')
    \ && (!exists('g:colors_name')
    \ || g:colors_name != 'base16-$BASE16_THEME')
  let base16colorspace=256
  colorscheme base16-$BASE16_THEME
endif
" }}}
