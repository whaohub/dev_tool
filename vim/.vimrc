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
Plug 'junegunn/fzf.vim'
Plug 'APZelos/blamer.nvim'
" Initialize plugin system
call plug#end()

"PLUGIN: coc
" use <tab> to trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
" Use <c-space> to trigger completion.
if has('nvim')
   inoremap <silent><expr> <c-space> coc#refresh()
else
     inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" " Use `:CocDiagnostics` to get all diagnostics of current buffer in location
" list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
"
"" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)"

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

"PLUGIN:grubbox theme
set bg=dark
set termguicolors
colo gruvbox


"PLUGIN: nerdtree shortcut
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

"PLUGIN: FZF
nnoremap <silent> <C-p> :FZF<CR>

"PLUGIN: blamer
let g:blamer_enabled = 0
let g:blamer_show_in_visual_modes = 0
let g:blamer_prefix = ' > '
""coc-clang config
let g:coc_global_extensions = ['coc-clangd']
