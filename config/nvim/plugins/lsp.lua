return {
  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    opts = {
      diagnostics = {
        underline = true,
        -- update_in_insert = false,
      },
      -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the inlay hints.
      inlay_hints = {
        enabled = false,
      },
      -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the code lenses.
      codelens = {
        enabled = false,
      },
      servers = {
        rust_analyzer = {
          setting = {
            ['rust-analyzer'] = {
              diagnostics = {
                enable = false;
              }
            }
          }
        }
        pyright,
      }
    },
  }
}
