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
Plug 'godlygeek/tabular'
Plug 'tpope/vim-commentary'

" Autocomplete and Searching
if has('nvim')
  Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/unite.vim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'w0rp/ale'

" Languages
"
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'

Plug 'lervag/vimtex', { 'for': ['tex', 'plaintex'] }
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'bohlender/vim-smt2'
Plug 'wannesm/wmnusmv.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'sheerun/vim-polyglot'

" Prose
Plug 'junegunn/limelight.vim'
Plug 'dbmrq/vim-ditto'
Plug 'reedes/vim-wordy'
Plug 'reedes/vim-lexical'
Plug 'ron89/thesaurus_query.vim'

" Git
Plug 'tpope/vim-fugitive'

" Transparent GPG file handling
Plug 'jamessan/vim-gnupg'
call plug#end()
filetype plugin indent on
" }}}

" Commons {{{
" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Space is the leader
:let mapleader = "\<space>"
" Window splitting
nmap <silent> <leader>- <C-w>s
nmap <silent> <leader>\| <C-w>v
" Window navigation like a sane person
nmap <silent> <C-Up> :wincmd k<CR>
nmap <silent> <C-Down> :wincmd j<CR>
nmap <silent> <C-Left> :wincmd h<CR>
nmap <silent> <C-Right> :wincmd l<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>

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
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
  hi clear SpellBad
  hi SpellBad cterm=underline
  hi clear SpellCap
  hi SpellCap cterm=underline
  hi clear SpellLocal
  hi SpellLocal cterm=underline
  hi clear SpellRare
  hi SpellRare cterm=underline
endif



" Use deoplete.
let g:deoplete#enable_at_startup = 1
" and also close the preview window automatically
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Prose
augroup prose
  au!
  au FileType markdown,mkd,text,tex,plaintex call lexical#init()
  au FileType markdown,mkd,text,tex,plaintex DittoOn
augroup END

let g:wordy#ring = [
  \ ['weak', 'problematic', 'redundant', 'weasel', 'being', 'passive-voice', ],
  \ ['colloquial', 'idiomatic', 'similies', ],
  \ ['contractions', 'opinion', 'vague-time', 'said-synonyms', ],
  \ ['adjectives', 'adverbs', ]
  \ ]

nnoremap <leader>pf :NextWordy<CR>

let g:lexical#thesaurus = ['~/.local/share/nvim/thesaurus/mthesaur.txt',]
let g:lexical#thesaurus_key = '<leader>pt'

" LanguageServers
if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif
if executable('cquery')
   au User lsp_setup call lsp#register_server({
      \ 'name': 'cquery',
      \ 'cmd': {server_info->['cquery']},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
      \ 'initialization_options': { 'cacheDirectory': '/path/to/cquery/cache' },
      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
      \ })
endif
if executable('hie-wrapper')
   au User lsp_setup call lsp#register_server({
      \ 'name': 'hie',
      \ 'cmd': {server_info->['hie']},
      \ 'whitelist': ['haskell'],
      \ })
endif
if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif

" Actions
nnoremap <leader>lf :LspDocumentFormat<CR>
"nnoremap <leader>lf :LspDocumentRangeFormat<CR>
nnoremap <leader>lr :LspRename<CR>

" Navigation
nnoremap <leader>lgi :LspImplementation<CR>
nnoremap <leader>lgt :LspTypeDefinition<CR>
nnoremap <leader>lgd :LspDefinition<CR>
nnoremap <leader>lge :LspNextError<CR>
nnoremap <leader>lGe :LspPreviousError<CR>

" Show things
nnoremap <leader>lsa :LspCodeAction<CR>
nnoremap <leader>lsd :LspDocumentDiagnostics<CR>
nnoremap <leader>lsh :LspHover<CR>
nnoremap <leader>lsr :LspReferences<CR>
nnoremap <leader>lss :LspWorkspaceSymbol<CR>
"nnoremap <leader>lss :LspDocumentSymbol
nnoremap <silent> <leader>lst :TagbarToggle<CR>

" Denite
if has('nvim')
  nnoremap <silent> <leader>ob :Denite buffer<CR>
  nnoremap <silent> <leader>of :Denite file<CR>
  nnoremap <silent> <leader><leader> :Denite command<CR>
endif

" }}}

" NeoVim Setting {{{
if has("nvim")
	" True Colors
	"let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
	"let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
	set clipboard+=unnamedplus
	" Better substitute handling with preview
	set inccommand=nosplit
endif
" }}}
