Plug 'https://github.com/junnplus/nvim-lsp-setup'
Plug 'https://github.com/neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'https://github.com/williamboman/nvim-lsp-installer'
Plug 'https://github.com/hrsh7th/cmp-nvim-lsp'
Plug 'https://github.com/hrsh7th/cmp-buffer'
Plug 'https://github.com/hrsh7th/cmp-path'
Plug 'https://github.com/hrsh7th/cmp-cmdline'
Plug 'https://github.com/hrsh7th/nvim-cmp'
Plug 'https://github.com/hrsh7th/cmp-vsnip'
Plug 'https://github.com/hrsh7th/vim-vsnip'
Plug 'https://github.com/nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'simrat39/rust-tools.nvim'
Plug 'autozimu/LanguageClient-neovim', {
\ 'branch': 'next',
\ 'do': 'bash install.sh',
\ }
function SetupTreesitter()
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
      "lua",
      "html",
      "css",
      "dockerfile",
      "javascript",
      "ruby",
      "scss",
    }
}
EOF
endfunction

function SetupLsp()
lua << EOF
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

require('lspconfig')['solargraph'].setup{
  on_attach = on_attach,
  flags = lsp_flags
}

require('nvim-lsp-setup').setup({
    mappings = {
        gf = 'lua vim.lsp.buf.formatting()',
        gd = 'lua require"telescope.builtin".lsp_definitions()',
        gi = 'lua require"telescope.builtin".lsp_implementations()',
        gr = 'lua require"telescope.builtin".lsp_references()',
    },
    servers = {
        solargraph = {},
    },
})
EOF
endfunction

function SetupCompletion()
lua <<EOF
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      { name = 'path' },
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).       
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

EOF
endfunction

function SetupReact()
lua << EOF
local nvim_lsp = require('lspconfig')
nvim_lsp.tsserver.setup {}
nvim_lsp.diagnosticls.setup {
  on_attach = on_attach,
  filetypes = { 'javascript', 'javascriptreact', 'json', 'typescript', 'typescriptreact', 'css', 'less', 'scss', 'markdown', 'pandoc' },
  init_options = {
    linters = {
      eslint = {
        command = 'eslint_d',
        rootPatterns = { '.git' },
        debounce = 100,
        args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
        sourceName = 'eslint_d',
        parseJson = {
          errorsRoot = '[0].messages',
          line = 'line',
          column = 'column',
          endLine = 'endLine',
          endColumn = 'endColumn',
          message = '[eslint] ${message} [${ruleId}]',
          security = 'severity'
        },
        securities = {
          [2] = 'error',
          [1] = 'warning'
        }
      },
    },
    filetypes = {
      javascript = 'eslint',
      javascriptreact = 'eslint',
      typescript = 'eslint',
      typescriptreact = 'eslint',
    },
    formatters = {
      eslint_d = {
        command = 'eslint_d',
        args = { '--stdin', '--stdin-filename', '%filename', '--fix-to-stdout' },
        rootPatterns = { '.git' },
      },
      prettier = {
        command = 'prettier',
        args = { '--stdin-filepath', '%filename' }
      }
    },
    formatFiletypes = {
      css = 'prettier',
      javascript = 'eslint_d',
      javascriptreact = 'eslint_d',
      json = 'prettier',
      scss = 'prettier',
      less = 'prettier',
      typescript = 'eslint_d',
      typescriptreact = 'eslint_d',
      json = 'prettier',
      markdown = 'prettier',
    }
  }
}
EOF
endfunction

function SetupLibrary()
lua << EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
    "tsx",
    "json",
    "yaml",
    "html",
    "scss",
    "ruby"
  },
}
EOF
endfunction

function SetupRustTool()
lua <<EOF
local nvim_lsp = require'lspconfig'

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

require('rust-tools').setup(opts)
EOF
endfunction

function SetupLanguageClient()
let g:LanguageClient_serverCommands = {
\ 'rust': ['rust-analyzer'],
\ }
endfunction

augroup LspOverrides
    autocmd!
    autocmd User PlugLoaded call SetupTreesitter()
    autocmd User PlugLoaded call SetupLsp()
    autocmd User PlugLoaded call SetupCompletion()
    autocmd User PlugLoaded call SetupReact()
    autocmd User PlugLoaded call SetupLibrary()
    autocmd User PlugLoaded call SetupRustTool()
    autocmd User PlugLoaded call SetupLanguageClient()
augroup END
