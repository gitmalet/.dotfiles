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
Plug 'tpope/vim-sleuth'

" Looks
Plug 'itchyny/lightline.vim'
Plug 'chriskempson/base16-vim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'ntpeters/vim-better-whitespace'

" More vim commands
" Not used at the moment
" Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

" Autocomplete and Format
if has('nvim')
	Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'chemzqm/denite-extra'
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
	Plug 'Shougo/unite.vim'
	Plug 'Shougo/deoplete.nvim'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'w0rp/ale'

" Languages
"
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'Shougo/neco-syntax'
" Plug 'zchee/deoplete-jedi', { 'for': 'python' }
" Plug 'pearofducks/ansible-vim'
Plug 'lervag/vimtex', { 'for': ['tex', 'plaintex'] }
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

" Prose
Plug 'dbmrq/vim-ditto', { 'for': ['text', 'tex', 'plaintex', 'markdown'] }
Plug 'reedes/vim-wordy', { 'for': ['text', 'tex', 'plaintex', 'markdown'] }
Plug 'reedes/vim-lexical', { 'for': ['text', 'tex', 'plaintex', 'markdown'] }

" Transparent GPG file handling
Plug 'jamessan/vim-gnupg'
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
colorscheme base16-dracula

" Use deoplete.
let g:deoplete#enable_at_startup = 1
" and also close the preview window automatically
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Prose
augroup lexical
	autocmd!
	autocmd FileType markdown,mkd,text,tex,plaintex call lexical#init()
augroup END

au FileType markdown,mkd,text,tex,plaintex DittoOn

" LanguageServers
" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'c': ['cquery', 'clangd'],
    \ 'cpp': ['cquery', 'clangd'],
    \ 'python': ['pyls'],
    \ }

nnoremap <silent> <leader>li :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> <leader>ld :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <leader>lr :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> <leader>lf :call LanguageClient_textDocument_rangeFormatting()<CR>

" Denite
if has('nvim')
nnoremap <silent> <leader>ob :Denite buffer<CR>
nnoremap <silent> <leader>of :Denite file<CR>
endif
" }}}

" NeoVim Setting {{{
if has("nvim")
	" True Colors
	"let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
	"let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
	set clipboard+=unnamedplus
endif
" }}}
