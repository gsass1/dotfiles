set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'rust-lang/rust.vim'
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
Plugin 'elixir-editors/vim-elixir'
Plugin 'chr4/nginx.vim'
Plugin 'posva/vim-vue'
Plugin 'CreaturePhil/vim-handmade-hero'

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
    set guifont=Liberation\ Mono\:h15\:cANSI\:qDRAFT
  else
    " set guifont=Inconsolata-g\ for\ Powerline\ Medium\ 10
    set guifont=Liberation\ Mono\ for\ Powerline\ 11
  endif
endif

set backspace=indent,eol,start

if !has("gui_running")
  if has("win32")
    set term=win32
  endif
endif

set t_Co=256

colorscheme handmade-hero
set background=dark
set fillchars+=vert:\ 
set lazyredraw

set guiheadroom=0
set guioptions-=e

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
  autocmd GUIEnter * cd \

  if has("gui_running")
	map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
  endif
endif

" F5 launches python
autocmd BufNewFile,BufRead *.py map <F5> :!python %:p<CR>
autocmd BufNewFile,BufRead *.rb map <F5> :!ruby %:p<CR>

autocmd BufNewFile,BufRead *.c set noexpandtab ts=8 sw=8 ai
autocmd BufNewFile,BufRead *.cpp set noexpandtab ts=8 sw=8 ai
autocmd BufNewFile,BufRead *.{css,scss,sass} set expandtab ts=2 sw=2 ai
autocmd BufNewFile,BufRead *.coffee set expandtab ts=2 sw=2 ai
autocmd BufNewFile,BufRead *.html set expandtab ts=2 sw=2 ai
autocmd BufNewFile,BufRead *.php set expandtab ts=2 sw=2 ai
autocmd BufNewFile,BufRead *.rb set expandtab ts=2 sw=2 ai
autocmd BufNewFile,BufRead *.{yml,yaml} set filetype=ansible
autocmd BufNewFile,BufRead *.vue set filetype=vue expandtab ts=2 sw=2 ai
autocmd BufNewFile,BufRead nginx.conf set filetype=nginx

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

xnoremap p "_dP

function! s:insert_gates()
	let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
	execute "normal! i#ifndef " . gatename
	execute "normal! o#define " . gatename . " "
	execute "normal! Go#endif"
	normal! O
endfunction
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()

set nowrap

vnoremap > >gv
vnoremap < <gv

nnoremap <silent><C-Right> :wincmd l<CR>
nnoremap <silent><C-Left> :wincmd h<CR>
nnoremap <silent><C-Up> :wincmd k<CR>
nnoremap <silent><C-Down> :wincmd j<CR>
inoremap <silent><C-Right> <ESC>:wincmd l<CR>
inoremap <silent><C-Left> <ESC>:wincmd h<CR>
inoremap <silent><C-Up> <ESC>:wincmd k<CR>
inoremap <silent><C-Down> <ESC>:wincmd j<CR>

nnoremap <Space> @q

function! s:ExecuteInShell(command)
	let command = join(map(split(a:command), 'expand(v:val)'))
	let winnr = bufwinnr('^' . command . '$')
	silent! execute  winnr < 0 ? 'botright vnew ' . fnameescape(command) : winnr . 'wincmd w'
	setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap nonu
	echo 'Execute ' . command . '...'
	silent! execute 'silent %!'. command
	silent! execute 'resize '
	silent! redraw
	silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
	silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>'
	echo 'Shell command ' . command . ' executed.'
endfunction
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)

function! s:ExecuteBuildCommand()
	let shellargs = ''
	if has("win32")
		if !empty(glob(expand("%:p:h\\shell.bat")))
			let shellargs = shellargs . ' && shell'
		endif
		if !empty(glob(expand("%:p:h\\build.bat")))
			let shellargs = shellargs . ' && build'
		endif
	else
		if !empty(glob(expand("%:p:h\\Makefile")))
			let shellargs = shellargs . ' && make'
		endif
	endif
	silent! execute 'Shell cd %:p:h'.shellargs
	silent! execute 'windcmp p'
endfunction

command! -complete=shellcmd -nargs=+ Build call s:ExecuteBuildCommand()
autocmd BufRead *.{c,cpp,h,cxx,hpp} noremap <F5> :Build()<CR>

command EV :e ~/.vimrc
