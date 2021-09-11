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

" Standard plugins
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'

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

" More syntax highlighting
Plug 'sheerun/vim-polyglot'

" Discoverability and productivity improvement
Plug 'junegunn/fzf.vim'

" Heavy language support
Plug 'w0rp/ale'
Plug 'neovim/nvim-lspconfig'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

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

" Looks {{{{
let base16colorspace=256
colorscheme base16
" hi clear SpellBad
" hi SpellBad cterm=underline
" hi clear SpellCap
" hi SpellCap cterm=underline
" hi clear SpellLocal
" hi SpellLocal cterm=underline
" hi clear SpellRare
" hi SpellRare cterm=underline

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
nmap <leader>l :Lines<CR>
nmap <leader>s :Snippets<CR>
imap <leader>s <c-o>:Snippets<CR>
" }}}}

" Prose {{{{
let g:lexical#spelllang = ['en_us','en_gb','de_de', 'de_at']

augroup prose
  au!
  au FileType help,markdown,mkd,text,tex,plaintex call lexical#init()
  au FileType help,markdown,mkd,text,tex,plaintex call pencil#init({'wrap': 'soft'})
augroup END

" }}}}

" Completion {{{{

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


" neovim-lsp needs lua for some weird reason
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- Go to
  buf_set_keymap('n', '<leader>lgD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<leader>lgd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>lgt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>lgi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>lgr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

  -- Action
  buf_set_keymap('n', '<leader>lar', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>lac', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>laf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  -- Show
  buf_set_keymap('n', '<leader>lsh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>lss', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>lsd', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)

  -- Workspace
  buf_set_keymap('n', '<leader>lwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>lwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>lwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)

  -- Misc
  -- buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  -- buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  end

  -- Use a loop to conveniently call 'setup' on multiple servers and
  -- map buffer local keybindings when the language server attaches
  local servers = { 'rls', 'pylsp', 'texlab' }
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150,
      }
    }
end
EOF


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
" }}}
