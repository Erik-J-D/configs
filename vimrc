" Run Pathogen stuff
execute pathogen#infect() 

syntax enable " syntax highlighting

set t_Co=16
set background=dark
colorscheme default

set smartcase   " search intelligently
set smartindent

set hlsearch  " highlight searches, and search incrementaly
set incsearch
map <F2> <esc>:noh<cr><esc>
set wrapscan

set tabstop=4    " set tab to 4 spaces
set shiftwidth=4
set expandtab
highlight SpecialKey ctermfg=1  " highlight actual tabs
set list
set listchars=tab:>>

set colorcolumn=80
highlight ColorColumn ctermbg=darkgrey

autocmd FileType make       setlocal noexpandtab
autocmd FileType golang     setlocal noexpandtab
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab
autocmd Filetype javascript setlocal tabstop=2 shiftwidth=2 softtabstop=0 expandtab

set number "line numbers
set ruler

set noeb " turn off notifications
set visualbell
set t_vb=

set backspace=indent,eol,start " backspace continues on previous line

set nobackup  " get rid of swap files. we have git.
set nowb
set noswapfile

set so=10 " leave some text at the top / bottom of the screen

set whichwrap+=<,>,h,l,[,] " wrap arrow keys around lines

imap <F1> <nop>
nmap <F1> <nop>
set pastetoggle=<F5>
map <F7> <esc>:tabp<cr>  " map F7 F8 and F9 to previous, next, and new tab
map <F8> <esc>:tabn<cr>
map <F9> <esc>:tabe<cr>

set foldmethod=indent  "fold based on indent
set foldnestmax=10     "deepest fold is 10 levels
set nofoldenable       "dont fold by default
set foldlevel=1

"remap jj to escape in insert mode
inoremap jj <Esc>
