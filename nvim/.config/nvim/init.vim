set nocompatible                                    " Disable compatibility to old-time vi
set viminfo+=n~/.cache/nvim/viminfo                 " neo vim
set runtimepath^=~/.viDTreeShowHidden=1uvim/after   " neo vim
let &packpath = &runtimepath                        " neo vim
filetype plugin on
syntax enable                                       " turn on all the magic, including Explorer and syntax highlighting
set autoindent                                      " autoindent
set background=dark
set clipboard+=unnamedplus                          " yank to clipboard
set cursorline                                      " highlight current line
set encoding=UTF-8
set expandtab
set fileencoding=utf-8                              " The encoding written to file
set hidden                                          " Required to keep multiple buffers open multiple buffers
set hlsearch                                        " highlight matches
set ignorecase                                      " Do case insensitive matching
set inccommand=split
set incsearch                                       " search as characters are entered
set lazyredraw                                      " redraw only when we need to.
set mouse=a
set noshowmode
set nowrap
set number relativenumber                           " hybrid line numbers
set ruler              			                    " Show the cursor position all the time
set shiftwidth=4
set smartindent                                     " Makes indenting smart
set smarttab                                        " Makes tabbing smarter will realize you have 2 vs 4
set softtabstop=4
set spell
set spelllang=en_us
set splitbelow
set splitright
set tabstop=4
set timeoutlen=2000
set termguicolors
set updatetime=300                                  " Faster completion
set wildmenu
set wildmode=longest,list                           " get bash-like tab completions

" ===== PLUG INS =============================
call plug#begin('~/.cache/nvim/plugged')
  
 " themes
  Plug 'arcticicestudio/nord-vim'
  Plug 'cocopon/iceberg.vim'
  Plug 'jacoborus/tender.vim'
  Plug 'rakr/vim-one'
  Plug 'sainnhe/everforest'
  Plug 'joshdick/onedark.vim'

  " system
  Plug '907th/vim-auto-save'                        " Auto Save
  Plug 'airblade/vim-rooter'                        " current directory moves with file
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'                   
  Plug 'junegunn/vim-peekaboo'                      " show my registers, fool... 
  Plug 'justinmk/vim-sneak'
  Plug 'preservim/nerdtree'
  "Plug 'tpope/vim-fugitive'
  Plug 'itchyny/lightline.vim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'romgrk/barbar.nvim'

call plug#end()

source $HOME/.config/nvim/vim-sneak.vim
source $HOME/.config/nvim/nerd-tree.vim
source $HOME/.config/nvim/autosave.vim
source $HOME/.config/nvim/fzf.vim

" ===== EYE CANDY =========================
colorscheme one
let g:lightline = { 'colorscheme': 'tender' }

" ===== KEYS ==============================
let mapleader = "\<Space>"

" do not need shift to enter command mode
nnoremap ; :
vnoremap ; :

" Yank act like other capital letters
nnoremap Y y$

" Leader maps
nnoremap <leader>c :Commands<CR>
nnoremap <leader>h :History<CR>
nnoremap <leader>k :Maps<CR>
nnoremap <leader>l :Lines<CR>
nnoremap <leader>hh :Helptags<CR>
nnoremap <leader>s :Rg<CR>

nnoremap <leader>bb :Buffers<CR>
nnoremap <leader>bc :BufferClose<CR>
nnoremap <leader>bh :BufferMovePrevious<CR>
nnoremap <leader>bl :BufferMoveNext<CR>

nnoremap <leader>cl :set background=light<CR>
nnoremap <leader>cd :set background=dark<CR>
nnoremap <leader>cc :Colors

nnoremap <leader>e :NERDTreeToggle<CR>

nnoremap <leader>fc :Files $XDG_CONFIG_HOME<CR>
nnoremap <leader>fd :Files $DOTFILES<CR>
nnoremap <leader>fi :Files $INSTALLS<CR>
nnoremap <leader>ff :Files %:p:h<CR>
nnoremap <leader>fh :Files $HOME<CR>
nnoremap <leader>fs :Files $SRC<CR>
nnoremap <leader>ft :Filetypes<CR>

nnoremap <leader>pc :source $MYVIMRC<CR> :PlugClean<CR> :close
nnoremap <leader>pi :source $MYVIMRC<CR> :PlugInstall<CR> :close
nnoremap <leader>pu :source $MYVIMRC<CR> :PlugUpdate<CR> :close

nnoremap <leader>q  :quit<CR>

nnoremap <leader>rr :source $MYVIMRC<CR>

nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>tl :tabnext<cr>
nnoremap <leader>tc :tabclose<cr>

nnoremap <leader>ww :Windows<CR> 
nnoremap <leader>wc :close<CR> 
nnoremap <leader>wh <C-W><left> 
nnoremap <leader>wj <C-W><down> 
nnoremap <leader>wk <C-W><up> 
nnoremap <leader>wl <C-W><right> 
nnoremap <leader>ws :split<CR>
nnoremap <leader>wv :vsplit<CR>
nnoremap <leader>wxh :vertical resize -5<CR>
nnoremap <leader>wxj :resize -5<CR>
nnoremap <leader>wxk :resize +5<CR>
nnoremap <leader>wxl :vertical resize +5<CR>
