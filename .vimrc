"    `---------------------`
"    |       vundle        |
"    `---------------------`

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'CreaturePhil/vim-handmade-hero'
Plugin 'altercation/vim-colors-solarized'
Plugin 'alvan/vim-closetag'
Plugin 'chase/vim-ansible-yaml'
Plugin 'chr4/nginx.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'elixir-editors/vim-elixir'
Plugin 'jiangmiao/auto-pairs'
Plugin 'kchmck/vim-coffee-script'
Plugin 'mhinz/vim-startify'
Plugin 'morhetz/gruvbox'
Plugin 'mtth/scratch.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'posva/vim-vue'
Plugin 'rust-lang/rust.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'tikhomirov/vim-glsl'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-sensible'
Plugin 'triglav/vim-visual-increment'
Plugin 'vim-scripts/findstr.vim'

call vundle#end()

" startify
let g:startify_bookmarks = [ '~/.vimrc', '~/vimnotes.txt' ]

"    `---------------------`
"    |      powerline      |
"    `---------------------`

python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

let g:Powerline_symbols = "fancy"

"    `---------------------`
"    |  general settings   |
"    `---------------------`

filetype plugin indent on

set laststatus=2
set nonu

set incsearch
set hlsearch
set smartcase
set ignorecase

set smartindent
set autoindent

set nowrap

set t_Co=256

" Normal backspace behavior
set backspace=indent,eol,start

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

" Disable beeps
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" When pasting, don't save overriden content into clip
xnoremap p "_dP

" Keep selection when indenting
vnoremap > >gv
vnoremap < <gv

" I like using the q register for quick macros
nnoremap <Space> @q

" Can use CTRL+arrow keys for navigating windows
nnoremap <silent><C-Right> :wincmd l<CR>
nnoremap <silent><C-Left> :wincmd h<CR>
nnoremap <silent><C-Up> :wincmd k<CR>
nnoremap <silent><C-Down> :wincmd j<CR>
inoremap <silent><C-Right> <ESC>:wincmd l<CR>
inoremap <silent><C-Left> <ESC>:wincmd h<CR>
inoremap <silent><C-Up> <ESC>:wincmd k<CR>
inoremap <silent><C-Down> <ESC>:wincmd j<CR>

"    `---------------------`
"    |    gui and font     |
"    `---------------------`

syntax on
colorscheme handmade-hero
set background=dark
set fillchars+=vert:\ 
set lazyredraw

if has("gui_running")
  " CTRL-S for saving
  nnoremap <C-S>     :w<CR>

  set guioptions -=m
  set guioptions -=T
  set guioptions -=r
  set guioptions -=L
  set guiheadroom=0
  set guioptions-=e

  if has("gui_macvim")
    set guifont=Inconsolata-g\ for\ Powerline:h11
  elseif has("win32")
    set guifont=Liberation\ Mono\:h14\:cANSI\:qDRAFT

    " GVIM always starts in System32
    autocmd GUIEnter * cd \

    " Fullscreen plugin
    map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
  else
    set guifont=Liberation\ Mono\ for\ Powerline\ 11
  endif
else
  if has("win32")
    set term=win32
  endif
endif

"    `------------------------------------`
"    |    language settings + overrides   |
"    `------------------------------------`

autocmd BufNewFile,BufRead *.py map <F5> :!python %:p<CR>
autocmd BufNewFile,BufRead *.rb map <F5> :!ruby %:p<CR>

autocmd BufNewFile,BufRead *.{c,cpp,h,hpp} set expandtab ts=4 sw=4 ai
autocmd BufNewFile,BufRead *.{css,scss,sass} set expandtab ts=2 sw=2 ai
autocmd BufNewFile,BufRead *.coffee set expandtab ts=2 sw=2 ai
autocmd BufNewFile,BufRead *.html set expandtab ts=2 sw=2 ai
autocmd BufNewFile,BufRead *.php set expandtab ts=2 sw=2 ai
autocmd BufNewFile,BufRead *.rb set expandtab ts=2 sw=2 ai
autocmd BufNewFile,BufRead *.{yml,yaml} set filetype=ansible
autocmd BufNewFile,BufRead *.{vue,js} set filetype=javascript expandtab ts=2 sw=2 ai
autocmd BufNewFile,BufRead nginx.conf set filetype=nginx

"    `------------------------------------`
"    |    commands and custom extensions  |
"    `------------------------------------`

" insert_gates: when creating a file called name.h automatically add include
" guard
function! s:insert_gates()
	let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
	execute "normal! i#ifndef " . gatename
	execute "normal! o#define " . gatename . " "
	execute "normal! Go#endif"
	normal! O
endfunction
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()

" ExecuteInShell: execute a given command and redirect its output in a new buffer
"
" TODO: this waits until the command is finished, causing a delay. this might
" be annoying but for my use case it's acceptable. might wanna try using
" neovim's terminal feature in the future
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

" ExecuteBuildCommand: execute a build.bat or Makefile in the current
" directory using ExecuteInShell
function! s:ExecuteBuildCommand()
	silent! execute 'w'
	let shellargs = ''
	if has("win32")
		if !empty(glob(expand("%:p:h\\build.bat")))
			let shellargs = shellargs . ' && build'
		endif
	else
		if !empty(glob(expand("%:p:h/Makefile")))
			let shellargs = shellargs . ' && make'
		endif
	endif
	silent! execute 'cd' . expand("%p:h")
	silent! execute 'Shell cd %:p:h'.shellargs
	silent! execute 'set filetype=msvc'
	silent! execute 'wincmd p'
endfunction
command! -complete=shellcmd -nargs=+ Build call s:ExecuteBuildCommand()

" Map F5 to the build command
autocmd BufNew,BufRead *.{c,cpp,h,cxx,hpp} noremap <F5> :Build()<CR>

" GoToError: directly jump to the line of code of the error hovered on by the
" cursor. used in conjunction with ExecuteBuildCommand
"
" example:
"   c:\dev\ars\ars.cpp(62): error C2065: 'xxx': undeclared identifier
"
" NOTE: this only works for MSVC, gcc outputs differently
function! s:GoToError()
	let line = split(getline("."))
	if len(line) < 1
		return
	end

	if has("win32")
		let file_and_line = split(line[0], "(")
		if len(file_and_line) < 2
            let file_and_line = split(line[0], "|")
        endif
		if len(file_and_line) < 2
			echo "Cannot parse!"
			return
		endif
		let the_file = file_and_line[0]
		let line_number = split(file_and_line[1], ")")[0]
	else
		let file_and_line = split(line[0], ":")
		if len(file_and_line) < 2
			echo "Cannot parse!"
			return
		endif

		let the_file = file_and_line[0]
		let line_number = file_and_line[1]
	end
	let winnr = bufwinnr(the_file)
	if winnr > 0
		exec winnr . 'wincmd w'
	else
		exec 'wincmd p'
		exec "e " .  the_file
	endif
	exec  'normal! ' . line_number . 'G'
endfunction
command! -complete=shellcmd -nargs=+ GoToError call s:GoToError()
autocmd BufNew,BufRead *.{c,cpp,h,cxx,hpp} nnoremap <Return> :GoToError()<CR>

" SwitchHeaderSource: switch between file.cpp and file.h
function! s:SwitchHeaderSource()
	let file_and_ext = split(expand("%:t"), '\.')
	if len(file_and_ext) < 2
		echo 'Invalid filename'
		return
	end
	let this_file = file_and_ext[0]
	let ext = file_and_ext[1]
	let file_to_open = ''
	if match(ext, 'cpp') == 0
		let file_to_open = this_file . '.h'
	elseif match(ext, 'c') == 0
		let file_to_open = this_file . '.h'
	elseif match(ext, 'h') == 0
		if !empty(glob(this_file.'.cpp'))
			let file_to_open = this_file . '.cpp'
		elseif !empty(glob(this_file.'.c'))
			let file_to_open = this_file . '.c'
		end
	else
		echo 'Not a C/C++ extension: ' . ext
	endif

	if bufnr(file_to_open) > 0
		exec 'buffer ' . file_to_open
	else
		exec 'e ' . file_to_open
	endif
endfunction

command! -complete=shellcmd -nargs=+ SwitchHeaderSource call s:SwitchHeaderSource()
autocmd BufNew,BufRead *.{c,cpp,h,cxx,hpp} nnoremap <F3> :SwitchHeaderSource()<CR>

command! EV :e ~/.vimrc
noremap <F2> :so ~/.vimrc<CR>
noremap <F4> :nohlsearch<CR>

" When opening a file, cd to that file's directory
autocmd BufEnter * silent! lcd %:p:h
