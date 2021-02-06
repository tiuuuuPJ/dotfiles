" Allow backspace go beyond autoindents, eol, and starting point of insert mode.
set backspace=indent,eol,start

" Disable input methods in insert/search by default.
set iminsert=0 imsearch=-1

" Disable highlighting brackets
let loaded_matchparen = 1

" Use smart indenting method.
set autoindent smartindent

" Prefer Japanese help to English.
set helplang=ja,en

" Set the width of hard tabs as 8 (default).
set tabstop=4

" netrw is always tree view mode
let g:netrw_liststyle = 3

" use clipboard without plus
set clipboard&
set clipboard^=unnamedplus

""" backup===================================================
" Create a backup in $HOME/tmp only when writing.
set nobackup writebackup backupdir=$HOME/tmp
" Create a swapfile in $HOME/tmp.
set swapfile directory=$HOME/tmp
" Create an undofile in $HOME/tmp.
set undofile undodir=$HOME/tmp

" Use highlighted incremental search.
set incsearch hlsearch

" Enable syntax highlighting.
syntax enable

" set list on
set list
let &listchars="tab:>-,trail:-,eol:«"
set whichwrap=b,s,h,l,<,>,~,[,]

" Always show the status line.
set laststatus=2
" Show the command line.
set showcmd
" Show ruler (column/row number) in the status line.
set ruler

" Enable wild menu.
set wildmenu

" Enable mouse in normal/visual/insert/command.
set mouse=a

" Assume we have xterm2-compatible terminal.
set ttymouse=xterm2

" Enable filetype-dependent plugin and indent and autodetection.
filetype plugin indent on
set shiftwidth=4

" Highlight the zenkaku-space character to avoid confusion.
highlight ZenkakuSpace cterm=underline ctermfg=red gui=underline guifg=red guibg=#AAFFFF
match ZenkakuSpace /\%u3000\|\%x81\%x40\|\xa1\xa1/

" Disable spell-checking in general, but enable for certain filetypes.
set nospell
autocmd FileType markdown,html,tex setlocal spell
" Disable spell-checking for Japanese.
set spelllang=en,cjk

" Disable hard text wrapping.
set textwidth=0
set wrapmargin=0

" Set window title
" %f: absolue/relative path
set title
let &titlestring="vim %f"
""" key mapping ============================================================

""" color settings ==========================================================
set t_Co=256
