execute pathogen#infect()


" -----PLUGINS
let g:airline_powerline_fonts = 1

" -----SHORTCUTS
let mapleader = ","

noremap <C-Z> :update<CR>	"Save
noremap <C-E> :quit<CR>		"Quit
vnoremap < <gv				"Better indentation
vnoremap > >gv				"Better indentation PLUGIN-CONFIG

" -----COLORS
color wombat256mod
highlight ColorColumn ctermbg=darkgray
syntax on

set mouse=a

set exrc
set secure

set number

set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

set history=700
set undolevels=700

set nobackup
set nowritebackup
set noswapfile

set laststatus=2


