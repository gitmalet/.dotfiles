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
Plug 'sheerun/vim-wombat-scheme'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'ntpeters/vim-better-whitespace'

" Unite and other Shougo madness
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/unite.vim'

" NerdTree file browser
Plug 'scrooloose/nerdtree'

" Language and Syntax
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'rust-lang/rust.vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'leafgarland/typescript-vim'
Plug 'aklt/plantuml-syntax'

" More vim commands
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'christoomey/vim-tmux-navigator'
Plug 'argumentative.vim'
Plug 'godlygeek/tabular'

" Neomake for all kinds of stuff
Plug 'benekastah/neomake'

" Tmux integration
Plug 'christoomey/vim-tmux-navigator'

" Autocomplete and Format
Plug 'Chiel92/vim-autoformat'
Plug 'racer-rust/vim-racer'
Plug 'zchee/deoplete-jedi'
Plug 'eagletmt/neco-ghc'
Plug 'Shougo/echodoc.vim'
Plug 'Shougo/neopairs.vim'

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
:let mapleader = ","
nmap <leader>- <C-w>s
nmap <leader>\| <C-w>v

" Looks again
syntax on
set nu
set hidden
set laststatus=2

" 256 color schemes!
let base16colorspace=256

set background=dark
colorscheme base16-monokai
" colorscheme wombat

" Split below and right
set splitbelow
set splitright
" }}}

" Plugin specifics {{{
" Unite
if has("nvim")
	nnoremap <leader>e :Unite -start-insert file_rec/neovim buffer<cr>
else
	nnoremap <leader>e :Unite file_rec/async buffer<cr>
endif
nnoremap <leader>/ :Unite grep:.<cr>

" Racer
let g:racer_cmd=expand("$HOME/.multirust/toolchains/nightly/cargo/bin/racer")
let $RUST_SRC_PATH=expand("$HOME/dev/Rust/rustc-1.7.0/src/")

" Neomake
nnoremap <leader>c :Neomake<cr>
autocmd! BufWritePost * Neomake

" Pandoc
let g:pandoc#spell#default_langs = ['de', 'en_us', 'en_gb']

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

" }}}

" NeoVim Setting {{{
if has("nvim")
	" True Colors
	"let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
	"let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
	set clipboard+=unnamedplus
endif
" }}}
