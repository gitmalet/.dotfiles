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

if filereadable(expand("$HOME/.dotfiles/nvimrc-rust-plug"))
    source $HOME/.dotfiles/nvimrc-rust-plug
endif
if filereadable(expand("$HOME/.dotfiles/nvimrc-haskell-plug"))
    source $HOME/.dotfiles/nvimrc-haskell-plug
endif
if filereadable(expand("$HOME/.dotfiles/nvimrc-doc-plug"))
    source $HOME/.dotfiles/nvimrc-doc-plug
endif

" Sensible
Plug 'tpope/vim-sensible'

" Looks
Plug 'itchyny/lightline.vim'
Plug 'chriskempson/base16-vim'
Plug 'sheerun/vim-wombat-scheme'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'ntpeters/vim-better-whitespace'

" NerdTree file browser
Plug 'scrooloose/nerdtree'


" More vim commands
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'christoomey/vim-tmux-navigator'
Plug 'godlygeek/tabular'

" Neomake for all kinds of stuff
Plug 'benekastah/neomake'

" Tmux integration
Plug 'christoomey/vim-tmux-navigator'

" Git integration
Plug 'tpope/vim-fugitive'

" Autocomplete and Format
Plug 'Chiel92/vim-autoformat'
Plug 'zchee/deoplete-jedi'
Plug 'Shougo/echodoc.vim'
Plug 'Shougo/neopairs.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Syntax
Plug 'petRUShka/vim-sage'
Plug 'pearofducks/ansible-vim'

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }


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
:imap <leader><leader> <Esc>

" Looks again
syntax on
set nu
set hidden
set laststatus=2
set concealcursor=""

" 256 color schemes!
let base16colorspace=256

set background=dark
colorscheme base16-atelier-cave
" colorscheme wombat

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

if filereadable(expand("$HOME/.dotfiles/nvimrc-rust"))
    source $HOME/.dotfiles/nvimrc-rust
endif
if filereadable(expand("$HOME/.dotfiles/nvimrc-doc"))
    source $HOME/.dotfiles/nvimrc-doc
endif

" Neomake
nnoremap <leader>c :Neomake<cr>
autocmd! BufWritePost * Neomake

" Lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

" Nerdtree
let g:NERDTreeWinSize = 25

" Vim-Tmux-Navigator
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
let g:tmux_navigator_save_on_switch = 1

" Autoformat
nmap <Leader>f :Autoformat<CR>

if !exists("b:disable_autoformat")
	au BufWrite * :Autoformat
endif
let g:autoformat_autoindent = 0

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Keymappings for Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-N>"
let g:UltiSnipsJumpBackwardTrigger="<c-P>"
" }}}

" NeoVim Setting {{{
if has("nvim")
	" True Colors
	"let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
	"let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
	set clipboard+=unnamedplus
endif
" }}}
