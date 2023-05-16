-------------------
-- Mason
-------------------
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "rust_analyzer" },
}
require('mason-tool-installer').setup {
  ensure_installed = {
    { 'bash-language-server', auto_update = true },
    'lua-language-server',
    'vim-language-server',
    'stylua',
    'shellcheck',
    'editorconfig-checker',
    'impl',
    'json-to-struct',
    'luacheck',
    'misspell',
    'revive',
    'shellcheck',
    'shfmt',
    'staticcheck',
    'vint',
  },
  auto_update = false,
  run_on_start = true,
  start_delay = 3000, -- 3 second delay
  debounce_hours = 5, -- at least 5 hours between attempts to install/update
}
-------------------
-- Nvim Lsp Config
-------------------
--
require("neodev").setup({
  library = {
    enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
    -- these settings will be used for your Neovim config directory
    runtime = true, -- runtime path
    types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
    plugins = true, -- installed opt or start plugins in packpath
    -- you can also specify the list of plugins to make available as a workspace library
    -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
  },
  setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
  -- for your Neovim config directory, the config.library settings will be used as is
  -- for plugin directories (root_dirs having a /lua directory), config.library.plugins will be disabled
  -- for any other directory, config.library.enabled will be set to false
  override = function(root_dir, options) end,
  -- With lspconfig, Neodev will automatically setup your lua-language-server
  -- If you disable this, then you have to set {before_init=require("neodev.lsp").before_init}
  -- in your lsp start options
  lspconfig = true,
  -- much faster, but needs a recent built of lua-language-server
  -- needs lua-language-server >= 3.6.0
  pathStrict = true,
})
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
end

local lsp_flags = {
  debounce_text_changes = 150,
}
require('lspconfig')['yamlls'].setup{
    settings = {
    yaml = {
      keyOrdering = false
    }
  }
}
require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['lua_ls'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['rust_analyzer'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    settings = {
      ["rust-analyzer"] = {}
    }
}
require('lspconfig')['clangd'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    settings = {
      ["rust-analyzer"] = {}
    }
}



local saga = require 'lspsaga'

saga.setup({

})

local signs = {
  Error = ' ',
  Warn = ' ',
  Info = ' ',
  Hint = ' ',
}
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  virtual_text = {
    source = true,
  },
})

require "lsp_signature".setup({
bind = true, -- This is mandatory, otherwise border config won't get registered.
handler_opts = {
  border = "rounded"
}
})

require('bqf').setup({
    auto_enable = {
        description = [[Enable nvim-bqf in quickfix window automatically]],
        default = true
    },
    magic_window = {
        description = [[Give the window magic, when the window is splited horizontally, keep
            the distance between the current line and the top/bottom border of neovim unchanged.
            It's a bit like a floating window, but the window is indeed a normal window, without
            any floating attributes.]],
        default = true
    },
    auto_resize_height = {
        description = [[Resize quickfix window height automatically.
            Shrink higher height to size of list in quickfix window, otherwise extend height
            to size of list or to default height (10)]],
        default = false
    },
    preview = {
        auto_preview = {
            description = [[Enable preview in quickfix window automatically]],
            default = true
        },
        border_chars = {
            description = [[Border and scroll bar chars, they respectively represent:
                vline, vline, hline, hline, ulcorner, urcorner, blcorner, brcorner, sbar]],
            default = {'│', '│', '─', '─', '╭', '╮', '╰', '╯', '█'}
        },
        show_title = {
            description = [[Show the window title]],
            default = true
        },
        delay_syntax = {
            description = [[Delay time, to do syntax for previewed buffer, unit is millisecond]],
            default = 50
        },
        win_height = {
            description = [[The height of preview window for horizontal layout,
                large value (like 999) perform preview window as a "full" mode]],
            default = 15
        },
        win_vheight = {
            description = [[The height of preview window for vertical layout]],
            default = 15
        },
        wrap = {
            description = [[Wrap the line, `:h wrap` for detail]],
            default = false
        },
        buf_label = {
            description = [[Add label of current item buffer at the end of the item line]],
            default = true
        },
        should_preview_cb = {
            description = [[A callback function to decide whether to preview while switching buffer,
                with (bufnr: number, qwinid: number) parameters]],
            default = nil
        }
    },
    func_map = {
        description = [[The table for {function = key}]],
        default = [[see ###Function table for detail]],
    },
    filter = {
        fzf = {
            action_for = {
                ['ctrl-t'] = {
                    description = [[Press ctrl-t to open up the item in a new tab]],
                    default = 'tabedit'
                },
                ['ctrl-v'] = {
                    description = [[Press ctrl-v to open up the item in a new vertical split]],
                    default = 'vsplit'
                },
                ['ctrl-x'] = {
                    description = [[Press ctrl-x to open up the item in a new horizontal split]],
                    default = 'split'
                },
                ['ctrl-q'] = {
                    description = [[Press ctrl-q to toggle sign for the selected items]],
                    default = 'signtoggle'
                },
                ['ctrl-c'] = {
                    description = [[Press ctrl-c to close quickfix window and abort fzf]],
                    default = 'closeall'
                }
            },
            extra_opts = {
                description = 'Extra options for fzf',
                default = {'--bind', 'ctrl-o:toggle-all'}
            }
        }
    }
})
