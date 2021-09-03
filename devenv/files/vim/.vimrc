set wrap
set linebreak
set nolist  " list disables linebreak
set ai sw=2 expandtab
set laststatus=2
set nocompatible " be iMproved, required
set number
set tabstop=2 " number of visual spaces per TAB
set showcmd " show command in bottom bar
"set shiftwidth=2
"set expandtab
"set autochdir
set cursorline
"set cursorcolumn
set autoread
set list listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·,eol:↲
set updatetime=100
set cursorline
set cursorcolumn
set mouse=a " as oppose to 'a' or 'r'


set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"Plugin 'dhruvasagar/vim-table-mode' " Create tables
Plugin 'vim-airline/vim-airline' " Content at bottom of vim window.
Plugin 'vim-airline/vim-airline-themes'
"Plugin 'godlygeek/tabular'
"Plugin 'plasticboy/vim-markdown'
"Plugin 'preservim/nerdcommenter'
"Plugin 'severin-lemaignan/vim-minimap'
"Plugin 'beloglazov/vim-online-thesaurus'
"Plugin 'vim-scripts/indentpython.vim'
" Plugin 'gabrielelana/vim-markdown' " Markdown syntax highlighting
" Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic' " Plugin for xml tagging corrections. (like a linter)
Plugin 'altercation/vim-colors-solarized'
"Plugin 'dense-analysis/ale'
" Plugin 'tpope/vim-fugitive' " GitHub Wrapper
Plugin 'airblade/vim-gitgutter'
"Plugin 'vim-scripts/lightline'
" Color Schemes
"Plugin 'tomsar/molokai'
Plugin 'flazz/vim-colorschemes'
Plugin 'joshdick/onedark.vim' " onedark colortheme
"Plugin 'morhetz/gruvbox'
Plugin 'jnurmine/Zenburn'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ

syntax enable
colorscheme gruvbox
set bg=dark
"runtime matchit.vim
let g:airline_theme='jellybeans'

" Removes trailing spaces
function TrimWhiteSpace()
  %s/\s*$//
  ''
endfunction

map <F2> :call TrimWhiteSpace()<CR>
map! <F2> :call TrimWhiteSpace()<CR>
autocmd FileWritePre * call TrimWhiteSpace()
autocmd FileAppendPre * call TrimWhiteSpace()
autocmd FilterWritePre * call TrimWhiteSpace()
autocmd BufWritePre * call TrimWhiteSpace()

