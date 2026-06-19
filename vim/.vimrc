"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
"               ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"               ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"               ██║   ██║██║██╔████╔██║██████╔╝██║
"               ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║
"                ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"                 ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ~/.vimrc — plain Vim, no plugins

" ============================================================
" General
" ============================================================
set nocompatible              " disable Vi compatibility mode
filetype plugin indent on     " enable filetype detection, plugins, and indentation
syntax on                     " enable syntax highlighting
set encoding=UTF-8

" ============================================================
" UI
" ============================================================
set number relativenumber     " absolute line on cursor line, relative elsewhere
set signcolumn=yes            " always show sign column (prevents layout shift)
set cursorline                " highlight the line the cursor is on
set scrolloff=8               " keep lines visible above/below cursor when scrolling
set nowrap                    " do not wrap long lines
set showcmd                   " show partial command on the last line
set showmode                  " show current mode on the last line
set wildmenu                  " tab-completion menu in command mode
set wildmode=longest:full,full " complete longest match first, then cycle
set showmatch                 " briefly jump to matching bracket
set laststatus=2              " always show the status line

" ============================================================
" Editing
" ============================================================
set tabstop=4                 " tab displays as 4 spaces wide
set shiftwidth=4              " indent/dedent by 4 spaces
set expandtab                 " insert spaces instead of tabs
set smartindent               " auto-indent new lines
set backspace=indent,eol,start  " backspace over indent, line breaks, insert start

" ============================================================
" Search
" ============================================================
set hlsearch                  " highlight all search matches
set incsearch                 " show matches as you type
set ignorecase                " case-insensitive search
set smartcase                 " override ignorecase when pattern has uppercase

" ============================================================
" Clipboard & mouse
" ============================================================
set clipboard=unnamed         " use system clipboard for yank/paste
set mouse=a                   " mouse support in all modes

" ============================================================
" Files
" ============================================================
set autoread                  " reload file changed on disk outside Vim
set hidden                    " switch buffers without saving first
set noswapfile                " no swap files
set nobackup                  " no backup files
set history=1000              " command-line history depth
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

if version >= 703
    set undodir=~/.vim/backup
    set undofile
    set undoreload=10000
endif

" ============================================================
" Colors
" ============================================================
set background=dark
colorscheme default

" ============================================================
" Key mappings
" ============================================================
let mapleader = "\\"

nnoremap <leader>\ ``          " jump back to last cursor position
nnoremap jj <Esc>              " quick exit insert mode
inoremap jj <Esc>
nnoremap <space> :             " space opens command line
nnoremap o o<Esc>              " stay in normal mode after opening a line
nnoremap O O<Esc>
nnoremap n nzz                 " center match when searching
nnoremap N Nzz
nnoremap Y y$                  " yank to end of line

" Split navigation
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Resize splits
noremap <C-Up>    <C-w>+
noremap <C-Down>  <C-w>-
noremap <C-Left>  <C-w>>
noremap <C-Right> <C-w><

" Run Python script (F5)
nnoremap <F5> :w<CR>:!clear<CR>:!python3 %<CR>

" ============================================================
" Autocommands
" ============================================================
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

augroup filetype_html
    autocmd!
    autocmd FileType html setlocal tabstop=2 shiftwidth=2 expandtab
augroup END

augroup cursor_active_window
    autocmd!
    autocmd WinLeave * set nocursorline nocursorcolumn
    autocmd WinEnter * set cursorline cursorcolumn
augroup END

" ============================================================
" GUI (MacVim / gvim)
" ============================================================
if has('gui_running')
    set guifont=Monospace\ Regular\ 12
    set guioptions-=T           " hide toolbar
    set guioptions-=L           " hide left scrollbar
    set guioptions-=r           " hide right scrollbar
    set guioptions-=m           " hide menu bar
    set guioptions-=b           " hide bottom scrollbar

    nnoremap <F4> :if &guioptions=~#'mTr'<Bar>
        \set guioptions-=mTr<Bar>
        \else<Bar>
        \set guioptions+=mTr<Bar>
        \endif<CR>
endif

" ============================================================
" Status line
" ============================================================
set statusline=
set statusline+=\ %F\ %M\ %Y\ %R
set statusline+=%=
