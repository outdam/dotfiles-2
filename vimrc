set nocompatible
filetype off

" *********************************************
" Plugins
" *********************************************
call plug#begin('~/.vim/plugged')

" *** Editor UI

Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" " Colorscheme
Plug 'KeitaNakamura/neodark.vim'

" /* Tags
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'ludovicchabant/vim-gutentags'
Plug 'jszakmeister/markdown2ctags'


  " Generate tags for Ruby
  Plug 'tmm1/ripper-tags'

  " Generate tags for js with jsctags
  " 1. install tern_for_vim
  " Plug 'ternjs/tern_for_vim'
  " 2. npm install -g git+https://github.com/ramitos/jsctags.git

" *** Git

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" *** Editing

Plug 'tpope/vim-commentary'             " gc{motion}, v_gc, {number}gcc
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-surround'               " cs, ds, ys + {motion}
Plug 'tpope/vim-repeat'                 " 'solve repeated the last native command inside that map, rather than the map as a whole'

" *** Dev tools
" " IntelliSense with COC nvim
" Plug 'Shougo/neco-vim'
" Plug 'neoclide/coc-neco'
" Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}

Plug 'ctrlpvim/ctrlp.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'Valloric/MatchTagAlways'
Plug 'yggdroot/indentline'
  let g:indentLine_enabled = 0 " disable by default

Plug 'ntpeters/vim-better-whitespace'
Plug 'bogado/file-line'

 " " Test
 Plug 'janko-m/vim-test'
 Plug 'tpope/vim-dispatch'

 " " javascript
 " Plug 'pangloss/vim-javascript' " dependency for vim-jsx
 " Plug 'mxw/vim-jsx'

 " " HTML
 Plug 'mattn/emmet-vim'

" " Devops
Plug 'ekalinin/Dockerfile.vim'
Plug 'andrewstuart/vim-kubernetes'

" " Ruby
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'

"*** Vim ways

Plug 'kana/vim-operator-user'
Plug 'kana/vim-textobj-entire'          " object: e - through ggVG
Plug 'kana/vim-textobj-line'            " object: l
Plug 'kana/vim-textobj-user'            " requires bt vim-textobj-quotes
Plug 'wellle/targets.vim'               " object: a - arguments
Plug 'michaeljsmith/vim-indent-object'  " object: I - indent

Plug 'metakirby5/codi.vim'              "  interactive scratchpad like Numi, for programming languages
Plug 'junegunn/vim-easy-align'          " motion: ga
Plug 'easymotion/vim-easymotion'
" Plug 'zhou13/vim-easyescape'           " A visual distraction-free jj/jk to esc

" *** Other plugins
Plug 'machakann/vim-highlightedyank'
Plug 'simeji/winresizer'
Plug 'kshenoy/vim-signature'

" markdown
Plug 'godlygeek/tabular' " tabular must come before vim-markdown
Plug 'plasticboy/vim-markdown'
Plug 'jkramer/vim-checkbox'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

call plug#end()

" *********************************************
" General Configuaraion
" *********************************************

filetype plugin indent on

let mapleader=','

syntax enable
syntax on
set cursorline
set hidden                                     " All hiding unsaved buffer, and move on
set number
set numberwidth=4

set laststatus=2                               " Show the status line all the time
set lazyredraw
set nopaste
set showcmd
set ttyfast
set visualbell                                 " Disable sound

set autowrite                                  " autoload write
set autoread                                   " autoload read
au CursorHold,CursorHoldI,BufEnter * checktime " improve checktime frequency

set autoindent
set expandtab
set shiftwidth=2
set smartindent
set smarttab
set softtabstop=2
set tabstop=2

set nowrap                                     " Don't wrap lines
set linebreak                                  " Wrap lines at convenient points

set noswapfile                                 " turn off swap file
set nobackup                                   " disable creating backup file
set nowritebackup                              " disable write backup

set incsearch                                  " Search: Find as you type search
set hlsearch                                   " Search: Highlight search terms
set ignorecase                                 " Search: Case-insensitive searching.
set smartcase                                  " Search: But case-sensitive if expression contains a capital letter.

" Concealing
set conceallevel=2
set concealcursor="ni"

set nofoldenable

" Specifying Ruby path
let g:ruby_path = system('echo $HOME/.rbenv/shims')
let g:python3_host_prog = '/usr/local/bin/python3'

" *********************************************
" Windows
" *********************************************
" navigations between splitted windows
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-h> <c-w>h
nmap <c-l> <c-w>l

" *********************************************
" Navigations
" *********************************************
" Easy tabs navigation: Command+Shift+[
map <c-S-]> gt
map <c-S-[> gT

" Indenting in or out for visual selected
vmap <tab> >gv
vmap <s-tab> <gv

" *********************************************
" Colorscheme Configuaraion
" *********************************************
if filereadable($HOME . "/.vim/custom/vimrc_colorscheme_conf.vim")
  source ~/.vim/custom/vimrc_colorscheme_conf.vim
endif

" *********************************************
" Plugin Customization
" *********************************************
if filereadable($HOME . "/.vim/custom/vimrc_plugins_conf.vim")
	source ~/.vim/custom/vimrc_plugins_conf.vim
endif

" *********************************************
" Local custom config
" *********************************************
if filereadable($HOME . "/.dotfiles/vimrc_local.vim")
	source ~/.dotfiles/vimrc_local.vim
endif
