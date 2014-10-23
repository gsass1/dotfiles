set expandtab
set tabstop=4
set number
set shiftwidth=4

syntax on
colorscheme evening
set guifont=Droid\ Sans\ Mono:h10

" No arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" No hjkl
noremap h <NOP>
noremap j <NOP>
noremap k <NOP>
noremap l <NOP>

" Map window commands to hjkl
nmap <silent> h :wincmd h<CR>
nmap <silent> j :wincmd j<CR>
nmap <silent> k :wincmd k<CR>
nmap <silent> l :wincmd l<CR>

" Tab navigation like firefox
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i
inoremap <C-t>     <Esc>:tabnew<CR>

" GVIM always starts in System32
cd $HOME

" Autostart NERDTree
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

" Add fugitive to statusline
set statusline+=%{fugitive#statusline()}
