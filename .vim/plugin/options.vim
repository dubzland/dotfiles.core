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
set noswapfile
set nobackup
set undodir = "~/.local/share/vim/undodir"
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
silent! set statusline=[%n]\ %f\ [%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%{fugitive#statusline()}%=%c,%l/%L\ %P

augroup cursor_line
	au!
	au WinLeave,InsertEnter * set nocursorline nocursorcolumn
	au WinEnter,InsertLeave * set cursorline cursorcolumn
augroup END
" }}}

set mouse+=a
if &term =~ '^screen'
	set ttymouse=xterm2
endif

if has('conceal')
	set conceallevel=2 concealcursor=niv
endif

autocmd QuickFixCmdPost [^l]* cwindow

" Colors -------------- {{{
set termguicolors
if filereadable(expand("$HOME/.config/tinted-theming/set_theme.vim"))
  let base16_background_transparent=1
  let base16_colorspace=256
  source $HOME/.config/tinted-theming/set_theme.vim
endif
" }}}

" vim: foldmethod=marker
