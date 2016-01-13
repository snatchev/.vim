filetype off " required

" set the runtime path to include Vundle and initialize
set rtp+=~/vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'VundleVim/Vundle.vim'

Plugin 'rking/ag.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Plugin 'bling/vim-airline'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-haml'
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-rails'
Plugin 'skwp/vim-rspec'
Plugin 'vim-ruby/vim-ruby'
Plugin 'dag/vim-fish'

call vundle#end()            " required
filetype plugin indent on    " requiredfiletype plugin indent on

colorscheme Tomorrow-Night-Eighties

" Speed up things with `ag` instead of grep
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0 " no need to cache ag
end

" don't use fish for shell stuff
if &shell =~# 'fish$'
    set shell=sh
endif

" search for words under the cursor
nnoremap K :Ag "\b<C-R><C-W>\b"<CR>

vnoremap <C-c> "+y
" ctrl-s should save
nnoremap <silent> <C-S> :w<CR>
inoremap <C-S> <C-O>:w<CR>
vnoremap <C-c> "+y
" ctrl-s should save
nnoremap <silent> <C-S> :w<CR>
inoremap <C-S> <C-O>:w<CR>
" ctrl-w brackets for tab movement
nnoremap <C-W>] :tabnext<CR>
nnoremap <C-W>[ :tabprevious<CR>

if has("autocmd")
  " In Makefiles, use real tabs, not tabs expanded to spaces
  au FileType make set noexpandtab

  " treat json as javascript ?
  au BufNewFile,BufRead *.json set ft=javascript

  " Remember last location in file, but not for commit messages.
  " see :help last-position-jump
  au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif

  " remove trailing whitespace on save
  autocmd BufWritePre {*.txt,*.md,*.erb,*.rb,*.js,*.coffee,*.scss,*.haml,*.py,*.js,*.clj,*.php} :call <SID>CleanFile()

  " close NERDTree if it's the last window open
  autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
  autocmd BufWinEnter * NERDTreeMirror
endif

" map leader n to toggle nerd tree
map <leader>n :NERDTreeToggle<CR>

" map leader t to find the current file in nerdtree
noremap <leader>t :NERDTreeToggle<CR><c-w><c-p>:NERDTreeFind<CR>
set wildmenu
set autoread

let g:airline_powerline_fonts=1

" share a single NERDTree between buffers and tabs
if argc() == 0
  autocmd VimEnter * NERDTree
end

function! <SID>CleanFile()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let [l,c] = [line("."),col(".")]

    " Do the business:
    " %!git strip space
    silent! %s/\s\+$//e
    silent! %s#\($\n\s*\)\+\%$##

    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
