" vim:fdm=marker

  " Setup VimPlug {{{
  " If VimPlug is not installed, do it
  let bundleExists = 1

  if has("nvim")
    if (!filereadable(expand("$HOME/.config/nvim/autoload/plug.vim")))
      call system(expand("curl --proto-redir -all,https -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"))
    endif
  else
    if (!filereadable(expand("$HOME/.vim/autoload/plug.vim")))
      call system(expand("curl --proto-redir -all,https -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"))
    endif
  endif
  " }}}

" Get Plugins {{{
call plug#begin('~/.config/nvim/plugged')

" Standard plugins
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'nvim-lua/plenary.nvim'

" More vim commands
Plug 'godlygeek/tabular'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

" Looks
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Prose
Plug 'reedes/vim-wordy'
Plug 'reedes/vim-lexical'
Plug 'reedes/vim-pencil'
Plug 'rhysd/vim-grammarous'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Transparent GPG file handling
Plug 'jamessan/vim-gnupg'

" Syntax Highlighting
" Plug 'sheerun/vim-polyglot'
if has("nvim")
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'
  Plug 'nvim-treesitter/nvim-treesitter-context'
endif
Plug 'lifepillar/vim-formal-package', {'do': './convert_to_plugin.sh'}

" Discoverability and productivity improvement
Plug 'junegunn/fzf.vim'

" Heavy language support
Plug 'w0rp/ale'
Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp-document-symbol'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'dmitmel/cmp-digraphs'

Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-vsnip'

Plug 'nvim-orgmode/orgmode'
Plug 'Julian/lean.nvim'


call plug#end()
filetype plugin indent on
" }}}

" Commons {{{
" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Space is the leader
let g:mapleader = "\<space>"
let g:maplocalleader = ','

" Windows 
nmap <silent> <C-W>- :wincmd s<CR>
nmap <silent> <C-W>\| :wincmd v<CR>

" Basic looks
syntax on
set number relativenumber
set hidden
set laststatus=2
set concealcursor=""

" Split below and right
set splitbelow
set splitright

let g:tex_flavor = "latex"

" The holy Tabs vs Spaces war
" set tabstop=4
" set softtabstop=4
" set shiftwidth=4
" set noexpandtab

" }}}

" Plugin specifics {{{

" Looks {{{{
let base16colorspace=256
colorscheme base16
hi clear SpellBad
hi SpellBad cterm=underline
hi clear SpellCap
hi SpellCap cterm=underline
hi clear SpellLocal
hi SpellLocal cterm=underline
hi clear SpellRare
hi SpellRare cterm=underline

let g:airline_theme='base16'
let g:airline_powerline_fonts = 1

" " }}}}

" fzf {{{{
" Mappings for the mode
nmap <leader><leader> <plug>(fzf-maps-n)
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><leader> <plug>(fzf-maps-x)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><leader> <plug>(fzf-maps-o)
omap <leader><tab> <plug>(fzf-maps-o)

" Files, Buffers, Contents, Lines
nmap <leader>f :Files<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>c :Rg<CR>
" nmap <leader>l :Lines<CR>
nmap <leader>s :Snippets<CR>
imap <c-s> <c-o>:Snippets<CR>

" fzf completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)


" }}}}

" Prose {{{{
let g:lexical#spelllang = ['en_us','en_gb','de_de', 'de_at']

augroup prose
  au!
  au FileType help,markdown,mkd,text,tex,plaintex call lexical#init()
  au FileType help,markdown,mkd,text,tex,plaintex call pencil#init({'wrap': 'soft'})
augroup END

" }}}}

" Language Support {{{{

" Treesitter
runtime treesitter.lua

" Orgmode
runtime orgmode.lua

" nvim-cmp
set completeopt=menu,menuone,noselect
runtime cmp.lua

" LSP Config
runtime lspconfig.lua

" Disable ALE lsp
let g:ale_disable_lsp = 1

let g:ale_set_loclist = 1

" Some lsp servers have issues with backup files, see #649.
set nobackup
set nowritebackup


" TODO: Is this still relevant?
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif



" Use <C-j> to both expand and jump (make expand higher priority.)
" imap <C-j> <Plug>(coc-snippets-expand-jump)

" Diagnostics
nmap <silent> <leader>lds :lopen<CR>
nmap <silent> <leader>ldn <Plug>(ale_next_wrap)
nmap <silent> <leader>ldN <Plug>(ale_previous_wrap)
nmap <silent> <leader>ldp <Plug>(ale_previous_wrap)
nmap <silent> <leader>ldP <Plug>(ale_next_wrap)

" }}}}

" }}}

" NeoVim Setting {{{
if has("nvim")
	" True Colors
	set clipboard+=unnamedplus
	" Better substitute handling with preview
	set inccommand=nosplit
endif
