" vim:fdm=marker

" Setup VimPlug {{{
" If VimPlug is not installed, do it
let bundleExists = 1

if has("nvim")
	if (!filereadable(expand("$HOME/.config/nvim/autoload/plug.vim")))
		call system(expand("curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"))
	endif
else
	if (!filereadable(expand("$HOME/.vim/autoload/plug.vim")))
		call system(expand("curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"))
	endif
endif
" }}}

" Get Plugins {{{
call plug#begin('~/.config/nvim/plugged')

" Sensible
Plug 'tpope/vim-sensible'

" Looks
Plug 'itchyny/lightline.vim'
Plug 'chriskempson/base16-vim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'ntpeters/vim-better-whitespace'

" More vim commands
" Not used at the moment
" Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-surround'
" Plug 'tpope/vim-commentary'

" Neomake for all kinds of stuff
Plug 'benekastah/neomake'

" Autocomplete and Format
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" Languages
Plug 'Shougo/neco-syntax'
Plug 'zchee/deoplete-jedi'
Plug 'pearofducks/ansible-vim'
Plug 'lervag/vimtex'

call plug#end()
filetype plugin indent on
" }}}

" Commons {{{
" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Remappings
:let mapleader = "\<space>"
nmap <leader>- <C-w>s
nmap <leader>\| <C-w>v

" Looks again
syntax on
set nu
set hidden
set laststatus=2
set concealcursor=""

" Split below and right
set splitbelow
set splitright

" The holy Tabs vs Spaces war
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
" }}}

" Plugin specifics {{{
" Base16
let base16colorspace=256

set background=dark
colorscheme base16-atelier-heath

" Neomake
nnoremap <leader>c :Neomake<cr>
autocmd! BufWritePost * Neomake

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" }}}

" NeoVim Setting {{{
if has("nvim")
	" True Colors
	"let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
	"let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
	set clipboard+=unnamedplus
endif
" }}}
