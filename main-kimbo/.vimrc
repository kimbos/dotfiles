execute pathogen#infect()

syntax on


" -----PLUGINS
let g:airline_powerline_fonts = 1
"set guifont=Liberation\ Mono\ for\ Powerline
set encoding=utf-8

" -----SHORTCUTS
let mapleader = ","

noremap <C-Z> :update<CR>	"Save
noremap <C-E> :quit<CR>		"Quit
vnoremap < <gv				"Better indentation
vnoremap > >gv				"Better indentation PLUGIN-CONFIG

" -----COLORS

highlight ColorColumn ctermbg=darkgray
color wombat256mod
set t_Co=256

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
