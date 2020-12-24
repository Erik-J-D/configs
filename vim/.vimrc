set t_u7=
set t_RV=

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
Plug 'ctrlpvim/ctrlp.vim'
Plug 'itchyny/lightline.vim'
Plug 'kien/rainbow_parentheses.vim'
Plug 'leafoftree/vim-vue-plugin'
Plug 'morhetz/gruvbox'
Plug 'prettier/vim-prettier'
Plug 'psf/black'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
call plug#end()

" set up ctrl-p binding
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.tar.gz,*.zip,*.exe,*\\tmp\\*,.DS_Store,*/dist/*,*/node_modules/*,*/venv/*

let g:NERDDefaultAlign = 'left'
map <C-o> :NERDTreeToggle<CR>

command! -nargs=* -bar -bang -count=0 -complete=dir E Explore <args>

syntax enable " syntax highlighting
filetype indent plugin on

set autoread " auto-read when a file is changed on disk outside vim
if ! exists("g:CheckUpdateStarted")
    let g:CheckUpdateStarted=1
    call timer_start(1,'CheckUpdate')
endif
function! CheckUpdate(timer)
    silent! checktime
    call timer_start(1000,'CheckUpdate')
endfunction

set t_Co=256
set background=light
let g:gruvbox_italic=1

if &term !~# '^screen' && &term !~# '^tmux'
    set termguicolors
endif

colorscheme gruvbox

" use system clipboard - vim 7.3.74+
if system('uname -s') == "Darwin\n"
  set clipboard=unnamed "OSX
else
  set clipboard=unnamedplus "Linux
endif

set cindent
set cinkeys-=0#
set indentkeys-=0#

set smartcase   " search intelligently
set hlsearch  " highlight searches, and search incrementaly
set incsearch

map <F2> <esc>:noh<cr><esc>
set wrapscan

set tabstop=4    " set tab to 4 spaces
set softtabstop=4
set shiftwidth=4
set expandtab
highlight SpecialKey ctermfg=2  " highlight actual tabs
set list
set listchars=tab:▸·,trail:·

set tabpagemax=100
set showtabline=2

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

"remap jj to escape in insert mode
inoremap jj <Esc>

com! FormatJSON %!python3 -m json.tool
com! FormatXML %!xmllint --format


" Restore cursor position, window position, and last search after running a
" command.
function! Preserve(command)
  " Save the last search.
  let search = @/

  " Save the current cursor position.
  let cursor_position = getpos('.')

  " Save the current window position.
  normal! H
  let window_position = getpos('.')
  call setpos('.', cursor_position)

  " Execute the command.
  execute a:command

  " Restore the last search.
  let @/ = search

  " Restore the previous window position.
  call setpos('.', window_position)
  normal! zt

  " Restore the previous cursor position.
  call setpos('.', cursor_position)
endfunction

" Remove all trailing whitespace on save
autocmd BufWritePre * :call Preserve("%s/\\s\\+$//e")

"Language specific shit
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_typescript_checkers=['eslint']
let g:syntastic_python_python_exec = 'python3'

"Format scheme on save
autocmd BufWritePre *.ss,*.scm call Preserve('normal gg=G')

"JS shit
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue Prettier

"Python shit
autocmd BufWritePre *.py execute ':Black'

"Rust shit
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1

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
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ 'component': {
      \   'lineinfo': '%l/%L:%-3v'
      \ },
      \ }
