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

" More vim commands
Plug 'godlygeek/tabular'
Plug 'tpope/vim-commentary'

" Looks
Plug 'itchyny/lightline.vim'
Plug 'chriskempson/base16-vim'

" Autocomplete and language support
Plug 'liuchengxu/vim-which-key'
Plug 'w0rp/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'honza/vim-snippets'

" Prose
Plug 'reedes/vim-wordy'
Plug 'reedes/vim-lexical'
Plug 'reedes/vim-pencil'
Plug 'rhysd/vim-grammarous'

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
let g:mapleader = "\<space>"
let g:maplocalleader = ','

" Windows 
nmap <silent> <leader>w- :wincmd s<CR>
nmap <silent> <leader>w\| :wincmd v<CR>
nmap <silent> <leader>ws :wincmd s<CR>
nmap <silent> <leader>wv :wincmd v<CR>
nmap <silent> <leader>wk :wincmd k<CR>
nmap <silent> <leader>wj :wincmd j<CR>
nmap <silent> <leader>wh :wincmd h<CR>
nmap <silent> <leader>wl :wincmd l<CR>

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

" Prose {{{{
augroup prose
  au!
  au FileType markdown,mkd,text,tex,plaintex call lexical#init()
  au FileType markdown,mkd,text,tex,plaintex call pencil#init({'wrap': 'soft'})
augroup END

let g:wordy#ring = [
  \ ['weak', 'problematic', 'redundant', 'puffery', 'weasel', 'being', 'passive-voice', ],
  \ ['colloquial', 'idiomatic', 'similies', ],
  \ ['contractions', 'opinion', 'vague-time', 'said-synonyms', ],
  \ ['adjectives', 'adverbs', ]
  \ ]

let g:lexical#spelllang = ['en_us','en_gb','de_de', 'de_at']

" }}}}

" Base16 {{{{
let base16colorspace=256
colorscheme base16-horizon-dark
hi clear SpellBad
hi SpellBad cterm=underline
hi clear SpellCap
hi SpellCap cterm=underline
hi clear SpellLocal
hi SpellLocal cterm=underline
hi clear SpellRare
hi SpellRare cterm=underline
" }}}}

" Lightline {{{{
" Add diagnostic info for Lightline from CoC
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction'
      \ },
      \ }
" }}}}

" }}}

" Completion {{{

let g:coc_global_extensions= [
      \ 'coc-json',
      \ 'coc-python',
      \ 'coc-texlab',
      \ 'coc-vimlsp',
      \ 'coc-lists',
      \ 'coc-snippets'
  \ ]

" Which keys {{{{
" By default timeoutlen is 1000 ms
set timeoutlen=500

nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

" Make menu more descriptive

call which_key#register('<Space>', "g:which_key_map")

" Define prefix dictionary
let g:which_key_map =  {}

let g:which_key_map.w = { 'name' : '+window' }
" }}}}

" Options {{{{

" ALE and CoC compatibility
let g:ale_disable_lsp = 1

let g:ale_set_loclist = 1

" Better display for messages
set cmdheight=2

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" }}}}

" Mappings {{{{
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <C-l> to trigger snippet expand.
imap <C-s> <Plug>(coc-snippets-expand)

" Use <C-j> to select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> to jump to next placeholder
let g:coc_snippet_next = '<c-j>'

" Use <C-k> to jump to previous placeholder
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> to both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Language bindings
let g:which_key_map.l = { 'name' : '+language' }
let g:which_key_map.l.g = { 'name' : '+goto' }
let g:which_key_map.l.d = { 'name' : '+diagnostic' }
let g:which_key_map.l.a = { 'name' : '+action' }

" Diagnostics
nmap <silent> <leader>lds :lopen<CR>
nmap <silent> <leader>ldn <Plug>(ale_next_wrap)
nmap <silent> <leader>ldN <Plug>(ale_previous_wrap)
nmap <silent> <leader>ldp <Plug>(ale_previous_wrap)
nmap <silent> <leader>ldP <Plug>(ale_next_wrap)

" Navigation
nmap <silent> <leader>lgr <Plug>(coc-references)
nmap <silent> <leader>lgd <Plug>(coc-definition)
nmap <silent> <leader>lgt <Plug>(coc-type-definition)
nmap <silent> <leader>lgi <Plug>(coc-implementation)

" Code Actions
nmap <leader>lar <Plug>(coc-rename)
nmap <leader>laf <Plug>(coc-format-selected)
nmap <leader>laa <Plug>(coc-codeaction-selected)
nmap <leader>lal <Plug>(coc-codeaction)
nmap <leader>laf <Plug>(coc-fix-current)

nmap <leader>lh :call CocActionAsync('doHover')<CR>

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" }}}}

" }}}

" NeoVim Setting {{{
if has("nvim")
	" True Colors
	set clipboard+=unnamedplus
	" Better substitute handling with preview
	set inccommand=nosplit
endif
" }}}
