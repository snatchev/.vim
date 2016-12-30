"" https://raw.github.com/carlhuda/janus/master/janus/vim/core/before/plugin/mappings.vim
""
"" General Mappings (Normal, Visual, Operator-pending)
""

" use :w!! to write to a file using sudo if you forgot to 'sudo vim file'
" (it will prompt for sudo password when writing)
cmap w!! %!sudo tee > /dev/null %

" Toggle paste mode
nmap <silent> <F4> :set invpaste<CR>:set paste?<CR>
imap <silent> <F4> <ESC>:set invpaste<CR>:set paste?<CR>

" format the entire file
nmap <leader>fef ggVG=

" Next buffer
nmap <silent> ,. :bnext<CR>

" Previous buffer
nmap <silent> ,m :bprev<CR>

" upper/lower word
nmap <leader>u mQviwU`Q
nmap <leader>l mQviwu`Q

" upper/lower first char of word
nmap <leader>U mQgewvU`Q
nmap <leader>L mQgewvu`Q

" cd to the directory containing the file in the buffer
nmap <silent> <leader>cd :lcd %:h<CR>

" Create the directory containing the file in the buffer
nmap <silent> <leader>md :!mkdir -p %:p:h<CR>

" Some helpers to edit mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Swap two words
nmap <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`'

" Underline the current line with '='
nmap <silent> <leader>ul :t.\|s/./=/g\|:nohls<cr>

" set text wrapping toggles
nmap <silent> <leader>tw :set invwrap<CR>:set wrap?<CR>

" find merge conflict markers
nmap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" Map the arrow keys to be based on display lines, not physical lines
map <Down> gj
map <Up> gk

" Adjust viewports to the same size
map <Leader>= <C-w>=

""
"" Command-Line Mappings
""

" Insert the current directory into a command-line path
cmap <C-P> <C-R>=expand("%:p:h") . "/"

" iTerm 2 default key-mappings -> terminal codes

" move around in buffers
nnoremap <S-Up> :wincmd k<CR>
nnoremap <S-Down> :wincmd j<CR>
nnoremap <S-Right> :wincmd l<CR>
nnoremap <S-Left> :wincmd h<CR>

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
nnoremap <A-]> :tabnext<CR>
nnoremap <A-[> :tabprevious<CR>
nnoremap <A-t> :tabnew<CR>

nmap <S-Up> <C-W><Up>
nmap <S-Down> <C-W><Down>
nmap <S-Left> <C-W><Left>
nmap <S-Right> <C-W><Right>

" Indent / Outdent while maintaining selection
vmap <A-]> >gv
vmap <A-[> <gv

