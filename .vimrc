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
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'triglav/vim-visual-increment'

" Getting these to work on Windows is a pain in the ass
if !has("win32")
  Plugin 'Valloric/YouCompleteMe'
  Plugin 'rdnetto/YCM-Generator'
  let g:ycm_global_ycm_extra_conf = "~/.ycm_extra_conf.py"
endif

call vundle#end()

filetype plugin indent on

python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

let g:Powerline_symbols = "fancy"

set laststatus=2
set nonu

syntax on

if has("gui_running")
  set guioptions -=m
  set guioptions -=T
  set guioptions -=r
  set guioptions -=L
  if has("gui_macvim")
    set guifont=Inconsolata-g\ for\ Powerline:h11
  elseif has("win32")
    set guifont=Inconsolata\:h13\:cANSI\:qDRAFT
  else
    set guifont=Inconsolata-g\ for\ Powerline\ Medium\ 10
  endif
endif

set backspace=indent,eol,start

if !has("gui_running")
  set term=win32
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

" F5 launches python
autocmd BufNewFile,BufRead *.py map <F5> :!python %:p<CR>

autocmd BufNewFile,BufRead *.c set noexpandtab ts=8 sw=8 ai
autocmd BufNewFile,BufRead *.cpp set noexpandtab ts=8 sw=8 ai

" Disable beeps
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

set smartindent
set autoindent

" CTRL-S for saving
nnoremap <C-S>     :w<CR>

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
