set nocompatible              " required
set spell
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" All Plugins

Plugin 'mhartington/oceanic-next'
Plugin 'tmhedberg/SimpylFold'
" Plugin 'vim-scripts/indentpython.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
" Plugin 'zxqfl/tabnine-vim'
Plugin 'frazrepo/vim-rainbow'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'davidhalter/jedi-vim'
" Plugin 'ycm-core/YouCompleteMe'
Plugin 'itchyny/lightline.vim'

call vundle#end()            " required
filetype plugin indent on    " required
,

" setting horizontal and vertical splits
set splitbelow
set splitright

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za


" Setting up indendation

au BufNewFile, BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

au BufNewFile, BufRead *.js, *.html, *.css, *.adoc
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2

au FileType yaml setlocal ai ts=2 sts=2 sw=2 et
"
" Set column line
set cursorcolumn
set cursorline


highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" setting up pyflakes

let python_highlight_all=1
syntax on

" nerd tree settings
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" setting up line numbering
set nu

" Rainbow bracket settings
let g:rainbow_active = 1

" Theme
 syntax enable
" for vim 7
 set t_Co=256

" for vim 8
 if (has("termguicolors"))
  set termguicolors
 endif

" colorscheme OceanicNext
colorscheme desert
