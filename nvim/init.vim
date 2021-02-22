" ----------
" Vim Config
" ----------
"
"
" How this works:
"
" This file is minimal.  Most of the vim settings and initialization is in
" several files in .vim/init.  This makes it easier to find things and to
" merge between branches and repos.
"
" Please do not add configuration to this file, unless it *really* needs to
" come first or last, like Vundle and sourcing the machine-local config.
" Instead, add it to one of the files in .vim/init, or create a new one.

set nocompatible               " be iMproved
set autoread
filetype off                   " required!

set nu

call plug#begin('~/.vim/plugged')
"
" Colorschemes
"
Plug 'tpope/vim-vividchalk'
Plug 'chriskempson/vim-tomorrow-theme'

"
" Ruby / Rails
"
Plug 'tpope/vim-endwise'
"
" TS
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'

"
" PHP
"
Plug 'StanAngeloff/php.vim'

"
" General Editing
"
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ervandew/supertab'
Plug 'kien/rainbow_parentheses.vim'
Plug 'tpope/vim-sensible'
Plug 'guns/vim-sexp'
Plug 'junegunn/vim-easy-align'

"
" Window Management
"
" Plug 'ZoomWin'

"
" Searching
"
Plug 'epmatsw/ag.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"
" Navigation
"

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-vinegar'

"
" Languages
"
Plug 'vim-ruby/vim-ruby'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'plasticboy/vim-markdown'
Plug 'fatih/vim-go'
Plug 'wlangstroth/vim-racket'
Plug 'w0rp/ale'

"
" Development Tool Integration
"
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-dispatch'
Plug 'janko-m/vim-test'

"
" IntelliSense
"
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Initialize plugin system
call plug#end()

filetype plugin indent on
set colorcolumn=120

" COC settings
let g:coc_global_extensions = ['coc-solargraph']

" Linting
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_ruby_rubocop_executable = '/Users/aditya/.rbenv/shims/rubocop'

let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_javascript_eslint_options = ''
let g:ale_javascript_eslint_use_global = 1

let g:ale_linters = {
\ 'javascript': ['eslint'],
\ 'javascript.jsx': ['eslint'],
\ 'ruby': ['rubocop'],
\ 'typescript': ['eslint'],
\ 'typescript.tsx': ['eslint'],
\}

let g:ale_fixers = {
\ 'javascript': ['eslint'],
\ 'javascript.jsx': ['eslint'],
\ 'ruby': ['rubocop'],
\ 'typescript': ['eslint'],
\ 'typescript.tsx': ['eslint'],
\}


let g:typescript_compiler_binary = 'tsc'
let g:typescript_compiler_options = '--lib es6'

autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '.'
let g:ale_history_log_output = 1

let g:airline#extensions#ale#enabled = 1
syntax on

runtime! init/**.vim

""" FZF config

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout down / up / left / right
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_sink = 'e'

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

let fzf_source = 'fd --type file --follow --hidden --exclude .git --exclude node_modules'

"Temp to be able to edit go files
let g:go_gopls_enabled = 0

noremap <C-p> :call fzf#vim#files('', { 'source': fzf_source })<CR>

" Ag for word under cursor
nnoremap <silent> <Leader>ag :Ag! <C-R><C-W><CR>

""" end FZF

" vim-test config
let test#neovim#term_position = "right"
let test#vim#term_position = "right"
""" end vim-test config

set timeout timeoutlen=1000 ttimeoutlen=100
imap jk <Esc>

set foldmethod=indent
set backupdir=~/.vim/backups

if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
