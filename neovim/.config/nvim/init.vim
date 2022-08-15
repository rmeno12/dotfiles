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

Plug 'tomasr/molokai'

"vim sig?
"vimspector?

Plug 'voldikss/vim-floaterm'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

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

set expandtab
set shiftwidth=4
set softtabstop=4
set smarttab

set ignorecase
set smartcase

set autoindent
set smartindent

colorscheme molokai
""" set the bg to be terminal default
hi Normal ctermbg=NONE
hi LineNr ctermbg=NONE
hi SignCOlumn ctermbg=NONE


" BINDINGS & PLUGIN-SPECIFIC SETTINGS
"" bind space as leader
nnoremap <SPACE> <Nop>
let mapleader = " "

"" bind alternate tab/window navigation controls
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <silent> H :tabfirst<CR>
nnoremap <silent> L :tablast<CR>
nnoremap <silent> J :tabprev<CR>
nnoremap <silent> K :tabnext<CR>

"" coc
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
""" use tab and shift-tab to navigate completion menu
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
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
nmap <silent> <leader>y <Plug>(coc-type-definition)
nmap <silent> <leader>i <Plug>(coc-implementation)
nmap <silent> <leader>r <Plug>(coc-references)
""" other commands
nmap <leader>gn <Plug>(coc-diagnostics-next)
nmap <leader>gp <Plug>(coc-diagnostics-prev)
nmap <leader>n <Plug>(coc-rename)


"" vim-floaterm
noremap <silent> <C-t> :FloatermToggle<CR>
tnoremap <silent> <C-t> <C-\><C-n>:FloatermToggle<CR>
let g:floaterm_width = 0.9
let g:floaterm_height = 0.9

"" vim-airline
let g:airline_theme = 'molokai'
let g:airline_powerline_fonts = 1

"" vim-commentary
noremap <silent> <C-_> :Commentary<CR>
inoremap <silent> <C-_> <C-o>:Commentary<CR>

"" vim-gitgutter
hi GitGutterAdd ctermfg=2

"" nerdtree
nnoremap <silent> <leader>e :NERDTreeToggle<CR>
""" close vim if nerdtree is only window in only tab
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
""" close tab if nerdtree is only window in it
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
""" use same nerdtree on each tab
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif
let g:NERDTreeGitStatusUseNerdFonts = 1 " you should install nerdfonts by yourself. default: 0

