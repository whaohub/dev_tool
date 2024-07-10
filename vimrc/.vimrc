set t_Co=256
set nu
set showcmd
set encoding=utf-8
set autoindent
set tabstop=2
set expandtab
set softtabstop=2
set shiftwidth=4
set backspace=indent,eol,start
set  ruler
set showmatch
set incsearch
syntax on
filetype indent on

set undofile
set history=1000
set undodir=~/.vim/.undo//

set listchars=tab:»■,trail:■
set list

" vim-plug
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug '~/.fzf'
" Initialize plugin system
call plug#end()

" use <tab> to trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

"grubbox theme
set bg=dark
set termguicolors
colo gruvbox


"nerdtree shortcut
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

"coc-clang config
let g:coc_global_extensions = ['coc-clangd']
