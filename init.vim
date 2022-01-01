set exrc

set guicursor=
set relativenumber
set nu
set nohlsearch

set hidden
set noerrorbells

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

set nowrap
set smartcase

set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

set incsearch
set termguicolors
set t_Co=256
set scrolloff=8
set noshowmode
set completeopt=menuone,noinsert
set colorcolumn=120
set signcolumn=number
set background=dark

"Cursor settings:
"  1 -> blinking block
"  2 -> solid block
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar

" Mode Settings
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

call plug#begin('~/.vim/plugged')
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

Plug 'yggdroot/indentline'
Plug 'itchyny/lightline.vim'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

Plug 'tpope/vim-rails'
Plug 'tikhomirov/vim-glsl'

Plug 'aklt/plantuml-syntax'

Plug 'tpope/vim-fugitive'

Plug 'gruvbox-community/gruvbox'
call plug#end()

colorscheme gruvbox
highlight Normal guibg=none

let mapleader = " "
" mode lhs rhs
" Telescope mappings
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep for > ") })<CR>
nnoremap <leader>pf :Telescope find_files<CR>
nnoremap <leader>pb :Telescope current_buffer_fuzzy_find<CR>
nnoremap <leader>pl :lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>po :lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>
nnoremap <leader>pd :lua require('telescope.builtin').lsp_document_symbols()<CR>

" LSP mappings
nnoremap <leader>jd <cmd>lua vim.lsp.buf.definition()<CR>
"nnoremap <leader>K  <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <leader>ji <cmd>lua vim.lsp.buf.implementation()<CR>
"nnoremap <leader>jh <cmd>lua vim.lsp.buf.signature_help()<CR>
"nnoremap <leader>jt <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <leader>jr <cmd>lua vim.lsp.buf.references()<CR>
"nnoremap <leader>js <cmd>lua vim.lsp.buf.document_symbol()<CR>
"nnoremap <leader>jw <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
"nnoremap <leader>jl <cmd>lua vim.lsp.buf.declaration()<CR>

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<cr>" : "\<TAB>"

" Tab Nav
nnoremap <C-k> :bprev<CR>
nnoremap <C-j> :bnext<CR>
nnoremap <leader>bl :ls<CR>

" Window Nav
nnoremap <leader>e :Explore<CR>
nnoremap <leader>q :bd<CR>

" QuickFix Nav
nnoremap <leader>k :cprev<CR>
nnoremap <leader>j :cnext<CR>
nnoremap <leader>co :copen<CR>

" Visual Indent Keep Selected
vnoremap < <gv
vnoremap > >gv

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup ALEXB
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END

lua << EOF
    require'lspconfig'.solargraph.setup{on_attach=require'completion'.on_attach}
    require'lspconfig'.clangd.setup{on_attach=require'completion'.on_attach, cmd = { "clangd", "--background-index"}}
    require'lspconfig'.pyright.setup{on_attach=require'completion'.on_attach}
    require'lspconfig'.gopls.setup{on_attach=require'completion'.on_attach}
    require'lspconfig'.racket_langserver.setup{on_attach=require'completion'.on_attach}

    require'nvim-treesitter.configs'.setup { highlight = {enable = true}, incremental_selection = {enable = true}, textobjects = {enable = true}}
    require'nvim-treesitter.configs'.setup {
        playground = {
            enable = true,
            disable = {},
            updatetime = 25,
            persist_queries = false
        }
    }
EOF
