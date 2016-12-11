if has("gui_macvim")
  macmenu &File.New\ Tab key=<D-S-t>
  set guifont=Menlo\ for\ Powerline:h14
endif

" Map ⌘ + direction to change buffers
map <S-Down> <C-W><Down>
map <S-Up> <C-W><Up>
map <S-Left> <C-W><Left>
map <S-Right> <C-W><Right>
