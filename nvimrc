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

" More vim commands
" Not used at the moment
" Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-commentary'

" Autocomplete and language support
Plug 'w0rp/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'

" Search
Plug 'junegunn/fzf.vim'


Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'bohlender/vim-smt2'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
" Plug 'sheerun/vim-polyglot'

" Prose
Plug 'dbmrq/vim-ditto'
Plug 'reedes/vim-wordy'
Plug 'reedes/vim-lexical'
Plug 'reedes/vim-pencil'
Plug 'reedes/vim-litecorrect'

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


" fzf config
set rtp+=~/.fzf

" Show mappings
nmap <leader><tab> <plug>(fzf-maps-n)
nnoremap <leader>l? :call fzf#vim#maps('n')<cr>coc-

" Prose
augroup prose
  au!
  au FileType markdown,mkd,text,tex,plaintex call lexical#init()
  au FileType markdown,mkd,text,tex,plaintex DittoOn
  au FileType markdown,mkd,text,tex,plaintex call pencil#init({'wrap': 'soft'})
  au FileType markdown,mkd,text,tex,plaintex call litecorrect#init()
augroup END

let g:wordy#ring = [
  \ ['weak', 'problematic', 'redundant', 'puffery', 'weasel', 'being', 'passive-voice', ],
  \ ['colloquial', 'idiomatic', 'similies', ],
  \ ['contractions', 'opinion', 'vague-time', 'said-synonyms', ],
  \ ['adjectives', 'adverbs', ]
  \ ]

let g:lexical#spelllang = ['en_us','en_gb','de_de', 'de_at']

" }}}

" Completion {{{
" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use <c-space> to trigger <tab> to navigate and <enter> to commit.
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" Navigation
nmap <silent> <leader>lge <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>lGe <Plug>(coc-diagnostic-next)
nmap <silent> <leader>lgr <Plug>(coc-references)
nmap <silent> <leader>lgd <Plug>(coc-definition)
nmap <silent> <leader>lgy <Plug>(coc-type-definition)
nmap <silent> <leader>lgi <Plug>(coc-implementation)

" Snippets
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
imap <C-j> <Plug>(coc-snippets-expand-jump)

let g:coc_snippet_next = '<tab>'

" Show Documentation
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> <leader>lsd :call <SID>show_documentation()<CR>

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Code Actions
nmap <leader>lr <Plug>(coc-rename)
nmap <leader>lf  <Plug>(coc-format-selected)
nmap <leader>la  <Plug>(coc-codeaction-selected)
nmap <leader>lal  <Plug>(coc-codeaction)
nmap <leader>lfl  <Plug>(coc-fix-current)

" Show things
nnoremap <silent> <leader>lsd  :<C-u>CocList diagnostics<cr>
nnoremap <silent> <leader>lse  :<C-u>CocList extensions<cr>
nnoremap <silent> <leader>lsc  :<C-u>CocList commands<cr>
nnoremap <silent> <leader>lso  :<C-u>CocList outline<cr>
nnoremap <silent> <leader>lss  :<C-u>CocList -I symbols<cr>

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add diagnostic info for https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }

let g:coc_global_extensions= [
      \ 'coc-json',
      \ 'coc-rls',
      \ 'coc-python',
      \ 'coc-git',
      \ 'coc-vimlsp',
      \ 'coc-lists',
      \ 'coc-snippets'
  \ ]

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
