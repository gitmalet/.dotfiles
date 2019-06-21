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

" Autocomplete and language support
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
if has('nvim')
  Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
endif
Plug 'w0rp/ale'


Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'bohlender/vim-smt2'
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

" CoC
" Better display for messages
" set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


" Use `[c` and `]c` to navigate diagnostics
nmap <silent> <leader>lge <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>lGe <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> <leader>lgd <Plug>(coc-definition)
nmap <silent> <leader>lgy <Plug>(coc-type-definition)
nmap <silent> <leader>lgi <Plug>(coc-implementation)
nmap <silent> <leader>lgr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> <leader>lsd :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>lr <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>lf  <Plug>(coc-format-selected)
nmap <leader>lf  <Plug>(coc-format-selected)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>la  <Plug>(coc-codeaction-selected)
nmap <leader>la  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>lal  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>lfl  <Plug>(coc-fix-current)

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



" Using CocList
" Show all diagnostics
nnoremap <silent> <leader>lsd  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>lce  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>lcc  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>lo  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>ls  :<C-u>CocList -I symbols<cr>

let g:coc_global_extensions= [
      \ 'coc-json',
      \ 'coc-rls',
      \ 'coc-python',
      \ 'coc-git',
      \ 'coc-vimlsp',
      \ 'coc-vimtex',
      \ 'coc-lists',
  \ ]

" Show options
nmap <silent> <leader>l? :<C-u>map <leader>l<CR>

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
