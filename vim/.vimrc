if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'morhetz/gruvbox'
Plug 'sheerun/vim-polyglot'
Plug 'vim-syntastic/syntastic'
Plug 'mtscout6/syntastic-local-eslint.vim'
Plug 'prettier/vim-prettier'
Plug 'kien/rainbow_parentheses.vim'
Plug 'wlangstroth/vim-racket'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'jpalardy/vim-slime'
call plug#end()

" set up ctrl-p binding
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.tar.gz,*.zip,*.exe,*\\tmp\\*,.DS_Store,*/dist/*,*/node_modules/*

let g:NERDDefaultAlign = 'left'

" Ignore .jsx ext dependency for jsx in .js files
let g:jsx_ext_required = 0

" Suggested syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
autocmd VimEnter * SyntasticToggleMode " disable syntastic by default
map <F6> :SyntasticToggleMode<cr>

command! -nargs=* -bar -bang -count=0 -complete=dir E Explore <args>

syntax enable " syntax highlighting
filetype indent plugin on

set t_Co=256
set background=dark
let g:gruvbox_italic=1
set termguicolors
colorscheme gruvbox

set cindent
set cinkeys-=0#
set indentkeys-=0#

set smartcase   " search intelligently
set hlsearch  " highlight searches, and search incrementaly
set incsearch
highlight Search ctermbg=darkblue ctermfg=White

map <F2> <esc>:noh<cr><esc>
set wrapscan

set tabstop=4    " set tab to 4 spaces
set softtabstop=4
set shiftwidth=4
set expandtab
highlight SpecialKey ctermfg=2  " highlight actual tabs
set list
set listchars=tab:▸·,trail:·

set colorcolumn=80
highlight ColorColumn ctermbg=black

autocmd FileType make       setlocal noexpandtab
autocmd FileType golang     setlocal noexpandtab
autocmd Filetype html       setlocal tabstop=2 shiftwidth=2 expandtab
autocmd Filetype css        setlocal tabstop=2 shiftwidth=2 expandtab
autocmd Filetype ruby       setlocal tabstop=2 shiftwidth=2 expandtab
autocmd Filetype javascript setlocal tabstop=2 shiftwidth=2 softtabstop=0 expandtab
autocmd Filetype python     setlocal tabstop=4 shiftwidth=4 expandtab

set number
set ruler
set cursorline

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
nmap <F7> <esc>:tabp<cr>  " map F7 F8 and F9 to previous, next, and new tab
nmap <F8> <esc>:tabn<cr>
nmap <F9> <esc>:tabe<cr>

set foldmethod=indent  "fold based on indent
set foldnestmax=10     "deepest fold is 10 levels
set nofoldenable       "dont fold by default
set foldlevel=1

"remap jj to escape in insert mode
inoremap jj <Esc>

com! FormatJSON %!python -m json.tool
com! FormatXML %!xmllint --format

fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue Prettier

"vim-flake8
"map <F3> :call Flake8()<CR>
"autocmd BufWritePost *.py call Flake8()

"Make quickfix window scale with amount of stuff, max 10 lines
au FileType qf call AdjustWindowHeight(3, 10)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

" Rainbow parens
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"lightline
set laststatus=2
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

let g:slime_target = "vimterminal"
let g:slime_vimterminal_config = {}
let g:slime_vimterminal_cmd = "racket -I sicp"
