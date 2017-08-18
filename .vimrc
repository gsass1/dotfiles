set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'rust-lang/rust.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'kchmck/vim-coffee-script'
Plugin 'scrooloose/nerdtree'
Plugin 'tikhomirov/vim-glsl'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'scrooloose/nerdcommenter'
Plugin 'chase/vim-ansible-yaml'
Plugin 'morhetz/gruvbox'
Plugin 'triglav/vim-visual-incremen'

" Getting these to work on Windows is a pain in the ass
if !has("win32")
  Plugin 'Valloric/YouCompleteMe'
  Plugin 'rdnetto/YCM-Generator'
  let g:ycm_global_ycm_extra_conf = "~/.ycm_extra_conf.py"
endif

call vundle#end()

let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/'  }  }

filetype plugin indent on

python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

let g:Powerline_symbols = "fancy"

set laststatus=2
set number

syntax on

if has("gui_running")
  if has("gui_macvim")
    set guifont=Inconsolata-g\ for\ Powerline:h11
  elseif has("win32")
    set guifont=Inconsolata\:h10\:cANSI\:qDRAFT
  else
    set guifont=Inconsolata-g\ for\ Powerline\ Medium\ 10
  endif
endif

set backspace=indent,eol,start

if !has("gui_running")
  set term=xterm-256color
endif

set t_Co=256

colorscheme gruvbox

" Swap these as I find it easier like this
noremap = +
noremap + =

" Tab navigation like firefox
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i
inoremap <C-t>     <Esc>:tabnew<CR>

" GVIM always starts in System32
if has("win32")
  autocmd GUIEnter * cd $HOME
endif

" Autostart NERDTree when using GUI
autocmd GUIEnter * silent NERDTreeToggle
autocmd GUIEnter * wincmd p

silent! nmap <C-p> :NERDTreeToggle<CR>
silent! map <F3> :NERDTreeFind<CR>

" F5 launches python
autocmd BufNewFile,BufRead *.py map <F5> :!python %:p<CR>

autocmd BufNewFile,BufRead *.c set noexpandtab ts=8 sw=8 ai
autocmd BufNewFile,BufRead *.cpp set noexpandtab ts=8 sw=8 ai

let g:NERDTreeMapActivateNode="<F3>"
let g:NERDTreeMapPreview="<F4>"

" Disable beeps
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

set smartindent
set autoindent

" CTRL-S for saving
nnoremap <C-S>     :w<CR>
