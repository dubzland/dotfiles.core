" Bindings ------------ {{{
let mapleader = ","
let g:mapleader = ","

" {{{ Search
noremap <silent> <leader><space> :noh<CR>:call clearmatches()<CR>

" make search very magical
nnoremap / /\v
vnoremap / /\v
" }}}

" {{{ File explorer
nnoremap <leader>fe :Ex<CR>
" }}}

" {{{ Movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" }}}

" {{{ Text manipulation
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv

nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+Y
vnoremap <leader>Y "+Y

nnoremap <leader>p "_ddP
" }}}

" {{{ Window manipulation
nnoremap <leader>qk :Bclose<CR>
nnoremap <leader>qq :bwipeout<CR>
nnoremap <leader>wco :copen<CR>
nnoremap <leader>wcc :cclose<CR>
nnoremap <leader>wlo :lopen<CR>
nnoremap <leader>wlc :lclose<CR>
nnoremap <C-W>M <C-W>Pipe<C-W>
" }}}

" {{{ Fugitive
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gw :Gwrite<CR>
nnoremap <leader>gv :Gvdiffsplit<CR>
nnoremap <leader>gp :execute 'Git push origin '.FugitiveHead()<CR>
" }}}

" {{{ Undotree
nnoremap <leader>u :UndotreeToggle<CR>
" }}}

" {{{ Fuzzy-finding
nnoremap <leader>. :GFiles<CR>
nnoremap <C-p> :Files<CR>
nnoremap <leader>, :Rg<CR>
nnoremap <leader>b :Buffers<CR>

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --hidden --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" }}}

" vim: foldmethod=marker
