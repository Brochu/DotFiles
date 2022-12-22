-- Sets
vim.o.exrc = true

vim.o.guicursor = ""
vim.o.mouse = "c"
vim.o.relativenumber = true
vim.o.nu = true
vim.o.hlsearch = false

vim.o.hidden = true
vim.o.errorbells = false

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true

vim.o.wrap = false
vim.o.smartcase = true

vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.undodir = ""

vim.o.incsearch = true
vim.o.termguicolors = true
vim.o.scrolloff = 7
vim.o.showmode = false
vim.o.completeopt = "menu,menuone,noselect"
vim.o.colorcolumn = "120"
vim.o.signcolumn = "number"
vim.o.background = "dark"

-- Plugins
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.vim/plugged')

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug('nvim-treesitter/nvim-treesitter', {['do'] = vim.fn['nvim-treesitter#TSUpdate']})
Plug 'nvim-treesitter/playground'

Plug 'yggdroot/indentline'
Plug 'itchyny/lightline.vim'

Plug 'tpope/vim-fugitive'
Plug 'TimUntersberger/neogit'

Plug 'gruvbox-community/gruvbox'
Plug('catppuccin/nvim', { as = 'catppuccin'})

-- LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

-- For luasnip users.
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

-- Debugging
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'nvim-telescope/telescope-dap.nvim'

Plug 'simrat39/rust-tools.nvim'

vim.call('plug#end')

-- Colorscheme setup
local ok, catppuccin = pcall(require, "catppuccin")
if not ok then return end
catppuccin.setup({
	transparent_background = false,
	term_colors = false,
	dim_inactive = {
		enabled = false,
		shade = "dark",
		percentage = 0.15,
	},
	styles = {
		comments = { "italic" },
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
	},
	integrations = {
		cmp = true,
		telescope = true,
		treesitter = true,
	},
	color_overrides = {},
	custom_highlights = {},
})

vim.g.catppuccin_flavour = "macchiato"
vim.cmd[[colorscheme catppuccin]]
--vim.cmd[[colorscheme gruvbox]]

-- Key Mappings
function map(mode, shortcut, command)
    vim.api.nvim_set_keymap(mode, shortcut, command, {noremap = true, silent = true})
end

function nmap(shortcut, command)
    map('n', shortcut, command)
end

function imap(shortcut, command)
    map('i', shortcut, command)
end

function vmap(shortcut, command)
    map('v', shortcut, command)
end

vim.g.mapleader = " "

-- Telescope mappings
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find Opened Buffers' })
vim.keymap.set('n', '<leader>/', function()
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblen = 10,
        previewer = false,
    })
end, { desc = '[/] Fuzzy Find Current Buffer' })
vim.keymap.set('n', '<leader>f', require('telescope.builtin').find_files, { desc = 'Search [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch Current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch By [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
nmap("<A-m>", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>")

-- Diagnostics mappings
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>ll', vim.diagnostic.setloclist)

-- LSP mappings
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[R]e[n]ame' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ction' })

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[G]oto [D]efinition' })
vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { desc = '[G]oto [R]eferences' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = '[G]oto [I]mplementation' })
vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { desc = 'Type [D]efinition' })
vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, { desc = '[D]ocument [S]ymbols' })
vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, { desc = '[W]orkspace [S]ymbols' })

vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature Documentation' })

-- DAP mappings
--vim.keymap.set('n', "<F5>", "<cmd>lua require'dap'.continue()<CR>")
--vim.keymap.set('n', "<F10>", "<cmd>lua requir'dap'.step_over()<CR>")
--vim.keymap.set('n', "<F11>", "<cmd>lua require'dap'.step_into()<CR>")
--vim.keymap.set('n', "<F12>", "<cmd>lua require'dap'.step_out()<CR>")
--vim.keymap.set('n', "<leader>b", "<cmd>lua require'dap'.toggle_breakpoint()<CR>")
--vim.keymap.set('n', "<leader>dr", "<cmd>lua require'dap'.repl.open()<CR>")

-- Buffer Nav
vim.keymap.set('n', '<C-k>', '<cmd>bprev<CR>')
vim.keymap.set('n', '<C-j>', '<cmd>bnext<CR>')
vim.keymap.set('n', '<leader>bl', '<cmd>ls<CR>')
vim.keymap.set('n', '<leader>e', '<cmd>Explore<CR>')
vim.keymap.set('n', '<leader>q', '<cmd>bd<CR>')

-- Location List Nav
vim.keymap.set('n', '<C-h>', '<cmd>lprev<CR>')
vim.keymap.set('n', '<C-l>', '<cmd>lnext<CR>')
vim.keymap.set('n', '<leader>lo', '<cmd>lopen<CR>')
vim.keymap.set('n', '<leader>lc', '<cmd>lclose<CR>')

-- Shhhhh
vim.keymap.set('i', '<C-c>', '<C-[>')

-- Visual Indent Keep Selected
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Native LSP Setup
-- Global setup.
local cmp = require'cmp'
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = {
        ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm({ select = true }),

        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
    },
    sources = cmp.config.sources(
    {
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
    },
    {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    sources = cmp.config.sources(
    {
        { name = 'path' }
    },
    {
        { name = 'cmdline' }
    })
})


-- Setup lspconfig.
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
lspconfig.clangd.setup {
    capabilities = capabilities
}
lspconfig.pylsp.setup {
    capabilities = capabilities
}
lspconfig.rust_analyzer.setup {
    capabilities = capabilities
}
lspconfig.tsserver.setup {
    capabilities = capabilities
}
lspconfig.sumneko_lua.setup {
    capabilities = capabilities
}
--lspconfig.gopls.setup {
--	capabilities = capabilities,
--	on_attach = on_attach,
--	settings = {
--		gopls = {
--			gofumpt = true,
--		},
--	},
--	flags = {
--		debounce_text_changes = 150,
--	},
--}
--lspconfig.golint.setup {
--	capabilities = capabilities,
--	on_attach = on_attach,
--	settings = {
--		gopls = {
--			gofumpt = true,
--		},
--	},
--	flags = {
--		debounce_text_changes = 150,
--	},
--}


-- Setup Treesitter
local treesitterConfig = require('nvim-treesitter.configs')
treesitterConfig.setup {
    highlight = {enable = true},
    incremental_selection = {enable = true},
    textobjects = {enable = true},

    playground = {
        enable = true,
        disable = {},
        updatetime = 25,
        persist_queries = false,
    }
}
