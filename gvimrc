if has("gui_macvim")
  macmenu &File.New\ Tab key=<D-S-t>
  set guifont=Menlo\ for\ Powerline:h14
endif

" Map ⌘ + direction to change buffers
map <D-Down> <C-W><Down>
map <D-Up> <C-W><Up>
map <D-Left> <C-W><Left>
map <D-Right> <C-W><Right>

" Map ⌘ +t to open a new tab
map <D-t> :tabnew<CR>
