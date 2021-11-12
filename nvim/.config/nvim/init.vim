" Install vim-plug if not found
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.nvim/bundle')
  Plug 'Olical/conjure', {'tag': 'v4.24.0'}
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'kien/rainbow_parentheses.vim'
  Plug 'morhetz/gruvbox'
  Plug 'neovim/nvim-lspconfig'
  Plug 'preservim/nerdtree'
  Plug 'scrooloose/nerdcommenter'
  Plug 'shinchu/lightline-gruvbox.vim'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-fugitive'
  Plug 'wlangstroth/vim-racket'
call plug#end()

nnoremap <C-o> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
" Start NERDTree, unless a file or session is specified, eg. vim -S session_file.vim.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | NERDTree | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" set up ctrl-p binding
" let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
set wildignore+=*/tmp/*,*.so,*.swp,*.pyc,*.tar.gz,*.zip,*.exe,*\\tmp\\*,.DS_Store,*/dist/*,*/node_modules/*,*/venv/*,*/\.git/*

let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1

command! -nargs=* -bar -bang -count=0 -complete=dir E Explore <args>

syntax enable " syntax highlighting
filetype plugin indent on

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
if &term !~# '^screen' && &term !~# '^tmux'
    set termguicolors
endif
colorscheme gruvbox

" use system clipboard
if system('uname -s') == "Darwin\n"
  set clipboard=unnamed "OSX
else
  set clipboard=unnamedplus "Linux
endif

set cindent " auto indent braces
set cinkeys-=0#
set indentkeys-=0#

set smartcase " search intelligently
set hlsearch " highlight searches, and search incrementaly
set incsearch
set wrapscan
map <F1> <esc>:noh<cr><esc>

set tabstop=4 " set tab to 4 spaces
set softtabstop=4
set shiftwidth=4
set expandtab
highlight SpecialKey ctermfg=grey guifg=grey70  " highlight actual tabs
set list
set listchars=tab:▸·,trail:·

set tabpagemax=100 " Allow up to 100 files to be opened with [n]vim -p
set showtabline=2  " always show tabline

autocmd FileType make       setlocal noexpandtab
autocmd FileType golang     setlocal noexpandtab
autocmd Filetype css        setlocal softtabstop=2 shiftwidth=2
autocmd Filetype html       setlocal softtabstop=2 shiftwidth=2
autocmd Filetype javascript setlocal softtabstop=2 shiftwidth=2

set number
set ruler
set cursorline

set autowrite

set noeb " turn off notifications
set visualbell
set t_vb=

set nobackup  " get rid of swap files. we have git.
set nowb
set noswapfile

set so=10 " leave some text at the top / bottom of the screen

set backspace=indent,eol,start " backspace continues on previous line
set whichwrap+=<,>,h,l,[,] " wrap arrow keys around lines

set mouse=a

nmap <F7> <esc>:tabp<cr>  " map F7 F8 and F9 to previous, next, and new tab
nmap <F8> <esc>:tabn<cr>
nmap <F9> <esc>:tabe<cr>

com! FormatJSON %!python3 -m json.tool
com! FormatXML %!xmllint --format

" Remove all trailing whitespace on save
function! <SID>StripTrailingWhitespaces()
  if !&binary && &filetype != 'diff'
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
  endif
endfun
autocmd BufWritePre,FileWritePre,FileAppendPre,FilterWritePre * :call <SID>StripTrailingWhitespaces()

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

autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pylsp', 'gopls', 'html', 'cssls', 'vimls', 'jsonls', 'racket_langserver'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF
