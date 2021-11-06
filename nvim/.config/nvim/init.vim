set nocompatible                                    " Disable compatibility to old-time vi

"
"   /$$   /$$                     /$$    /$$ /$$              
"  | $$$ | $$                    | $$   | $$|__/              
"  | $$$$| $$  /$$$$$$   /$$$$$$ | $$   | $$ /$$ /$$$$$$/$$$$ 
"  | $$ $$ $$ /$$__  $$ /$$__  $$|  $$ / $$/| $$| $$_  $$_  $$
"  | $$  $$$$| $$$$$$$$| $$  \ $$ \  $$ $$/ | $$| $$ \ $$ \ $$
"  | $$\  $$$| $$_____/| $$  | $$  \  $$$/  | $$| $$ | $$ | $$
"  | $$ \  $$|  $$$$$$$|  $$$$$$/   \  $/   | $$| $$ | $$ | $$
"  |__/  \__/ \_______/ \______/     \_/    |__/|__/ |__/ |__/
"                                                            
                                                           

" ===== NEOVIM ============================
set viminfo+=n~/.cache/nvim/viminfo                 " neo vim
set runtimepath^=~/.viDTreeShowHidden=1uvim/after   " neo vim
let &packpath = &runtimepath                        " neo vim

" ===== SETS ==============================
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

" ===== PLUGS =============================
call plug#begin('~/.cache/nvim/plugged')
  
 " themes
  Plug 'lifepillar/vim-solarized8'
  Plug 'arcticicestudio/nord-vim'
  Plug 'cocopon/iceberg.vim'
  Plug 'habamax/vim-bronzage'
  Plug 'jacoborus/tender.vim'
  Plug 'joshdick/onedark.vim'
  Plug 'mhartington/oceanic-next'
  Plug 'morhetz/gruvbox'
  Plug 'sainnhe/everforest'
  Plug 'tomasr/molokai'
  Plug 'adlawson/vim-sorcerer'
  Plug 'xero/sourcerer.vim'

  " system
  Plug '907th/vim-auto-save'                        " Auto Save
  Plug 'airblade/vim-rooter'                        " current directory moves with file
  "Plug 'ap/vim-css-color'                           " highlight hex colors
  "Plug 'chrisbra/Colorizer'
  Plug 'itchyny/lightline.vim'
  Plug 'junegunn/vim-peekaboo'                      " show my registers, fool... 
  Plug 'justinmk/vim-sneak'
  Plug 'ryanoasis/vim-devicons'
  Plug 'ryanoasis/vim-devicons'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'romgrk/barbar.nvim'

  " files
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'                   
  Plug 'preservim/nerdtree'
  
call plug#end()

source $HOME/.config/nvim/vim-sneak.vim
source $HOME/.config/nvim/nerd-tree.vim
source $HOME/.config/nvim/autosave.vim
source $HOME/.config/nvim/fzf.vim


" ===== EYE CANDY =========================
colorscheme tender
" https://github.com/itchyny/lightline.vim/blob/master/colorscheme.md
let g:lightline = { 'colorscheme': 'tender'}

" ===== KEYS ==============================
let mapleader = "\<Space>"

" do not need shift to enter command mode
nnoremap ; :
vnoremap ; :

" Yank act like other capital letters
nnoremap Y y$

" Keeping it centered
nnoremap n nzzzv
nnoremap N Nzzzv

" Leader maps
nnoremap <leader><leader> :Lines<CR>
nnoremap <leader>ba :sav 
nnoremap <leader>bb :Buffers<CR>
nnoremap <leader>bc :BufferClose<CR>
nnoremap <leader>bh :BufferMovePrevious<CR>
nnoremap <leader>bl :BufferMoveNext<CR>
nnoremap <leader>bn :tabnew<CR>
nnoremap <leader>bs :w<CR>
nnoremap <leader>fc :Files $HOME/.config/<CR>
nnoremap <leader>fd :Files $HOME/.dotfiles/<CR>
nnoremap <leader>fi :Files $HOME/.installs/<CR>
nnoremap <leader>ff :Files %:p:h<CR>
nnoremap <leader>fh :Files $HOME<CR>
nnoremap <leader>fs :Files $HOME/src/<CR>
nnoremap <leader>pc :source $MYVIMRC<CR> :PlugClean<CR>
nnoremap <leader>pi :source $MYVIMRC<CR> :PlugInstall<CR>
nnoremap <leader>q  :quit<CR>
nnoremap <leader>rr :source $MYVIMRC<CR>
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>wc :close<CR> 
nnoremap <leader>wh <C-W><left> 
nnoremap <leader>wj <C-W><down> 
nnoremap <leader>wk <C-W><up> 
nnoremap <leader>wl <C-W><right> 
nnoremap <leader>wo :only<CR> 
nnoremap <leader>wq :close<CR> 
nnoremap <leader>ws :split<CR>
nnoremap <leader>wv :vsplit<CR>
nnoremap <leader>wxh :vertical resize -5<CR>
nnoremap <leader>wxj :resize -5<CR>
nnoremap <leader>wxk :resize +5<CR>
nnoremap <leader>wxl :vertical resize +5<CR>
nnoremap <leader>za :Commands<CR>
nnoremap <leader>zc :Colors<CR>
nnoremap <leader>zf :Filetypes<CR>
nnoremap <leader>zh :History<CR>
nnoremap <leader>zk :Maps<CR>
nnoremap <leader>zl :Lines<CR>
nnoremap <leader>zm :Marks<CR>
nnoremap <leader>zp :Helptags<CR>
nnoremap <leader>zs :Rg<CR>
nnoremap <leader>zt :Tags<CR>
nnoremap <leader>zw :Windows<CR> 
