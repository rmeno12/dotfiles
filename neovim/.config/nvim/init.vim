" PLUGINS
"" Automatically install VimPlug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"" Plugin declarations
call plug#begin(data_dir)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jackguo380/vim-lsp-cxx-highlight'

Plug 'rmeno12/vim-code-dark'

"vim sig?
"vimspector?

Plug 'voldikss/vim-floaterm'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'liuchengxu/vim-which-key'

Plug 'mhinz/vim-startify'

call plug#end()


" OPTIONS
syntax on
set encoding=UTF-8
set hidden
set cmdheight=2
set number
set mouse=nvi
set backspace=indent,eol,start
set clipboard=unnamedplus
set signcolumn=yes
set updatetime=250
set noshowmode

set expandtab
set shiftwidth=4
set softtabstop=4
set smarttab

set ignorecase
set smartcase

set autoindent
set smartindent

colorscheme codedark

""" open at the last cursor position
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif


" BINDINGS & PLUGIN-SPECIFIC SETTINGS
let g:which_key_map = {}

"" bind space as leader
nnoremap <SPACE> <Nop>
let mapleader = " "

"" bind alternate tab/window navigation controls
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <silent> H :tabprev<CR>
nnoremap <silent> L :tabnext<CR>

"" coc
""" checks if we're on the first character or right after whitespace
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
""" use tab and shift-tab to navigate completion menu
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
""" use enter to complete if necessary (kinda annoying, TODO: find a better way)
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
""" show documentation in preview window with K
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
""" go to relevant places
nmap <silent> <leader>d <Plug>(coc-definition)
let g:which_key_map.d = 'Definition'
nmap <silent> <leader>y <Plug>(coc-type-definition)
let g:which_key_map.y = 'Type Definition'
nmap <silent> <leader>i <Plug>(coc-implementation)
let g:which_key_map.i = 'Implementation'
nmap <silent> <leader>r <Plug>(coc-references)
let g:which_key_map.r = 'References'
""" other commands
nmap <leader>gn <Plug>(coc-diagnostics-next)
let g:which_key_map.g = { 'name': '+diagnostics' }
let g:which_key_map.g.n = 'Next'
nmap <leader>gp <Plug>(coc-diagnostics-prev)
let g:which_key_map.g.p = 'Previous'
nmap <leader>n <Plug>(coc-rename)
let g:which_key_map.n = 'Rename'
nnoremap <leader>f :call CocAction('format')<CR>
let g:which_key_map.f = 'Format'
""" fix highlighting with coc-clangd
let g:coc_default_semantic_highlight_groups = 1

"" vim-floaterm
noremap <silent> <C-t> :FloatermToggle<CR>
tnoremap <silent> <C-t> <C-\><C-n>:FloatermToggle<CR>
let g:floaterm_width = 0.9
let g:floaterm_height = 0.9

"" vim-airline
let g:airline_theme = 'codedark'
let g:airline_powerline_fonts = 1

"" vim-commentary
noremap <silent> <C-/> :Commentary<CR>
inoremap <silent> <C-/> <C-o>:Commentary<CR>

"" nerdtree
nnoremap <silent> <leader>e :NERDTreeToggle<CR>
let g:which_key_map.e = 'Toggle explorer'
""" close vim if nerdtree is only window in only tab
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
""" close tab if nerdtree is only window in it
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
""" use same nerdtree on each tab
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif
let g:NERDTreeGitStatusUseNerdFonts = 1

"" vim-which-key
set timeoutlen=500
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
call which_key#register('<Space>', "g:which_key_map")

