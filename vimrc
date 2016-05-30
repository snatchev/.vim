" Vundle Setup
filetype off " required

" set the runtime path to include Vundle and initialize
set rtp+=~/vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Shougo/deoplete.nvim'
Plugin 'bling/vim-airline'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Plugin 'dag/vim-fish'
Plugin 'edkolev/tmuxline.vim'
Plugin 'elixir-lang/vim-elixir'
Plugin 'kien/ctrlp.vim'
Plugin 'lambdatoast/elm.vim'
Plugin 'neomake/neomake'
Plugin 'pangloss/vim-javascript'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'skwp/vim-rspec'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'
Plugin 'vim-ruby/vim-ruby'
call vundle#end()            " required
filetype plugin indent on    " requiredfiletype plugin indent on


set wildmenu
set autoread

colorscheme Tomorrow-Night-Eighties

" enable deoplete
let g:deoplete#enable_at_startup = 1
"let g:deoplete#auto_complete_start_length = 4
let g:deoplete#auto_complete_delay = 100
let g:airline_powerline_fonts=1

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

" ========== auto commands ===========

" In Makefiles, use real tabs, not tabs expanded to spaces
autocmd FileType make set noexpandtab

" treat json as javascript ?
autocmd BufNewFile,BufRead *.json set ft=javascript

" Remember last location in file, but not for commit messages.
" see :help last-position-jump
autocmd BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal! g`\"" | endif

" remove trailing whitespace on save
autocmd BufWritePre {*.txt,*.md,*.erb,*.rb,*.js,*.coffee,*.scss,*.haml,*.py,*.js,*.clj,*.php} :call <SID>CleanFile()

" run a linter on save
autocmd! BufWritePost * Neomake
let g:neomake_warning_sign = {'text': '⚠️', 'texthl': 'LineNr'}
let g:neomake_error_sign = {'text': '❌', 'texthl': 'LineNr'}

" share a single NERDTree between buffers and tabs
if argc() == 0
  autocmd VimEnter * NERDTree
end

" map leader n to toggle nerd tree
map <leader>n :NERDTreeToggle<CR>

" map leader t to find the current file in nerdtree
noremap <leader>t :NERDTreeToggle<CR><c-w><c-p>:NERDTreeFind<CR>

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
