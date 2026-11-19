return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
  },
  {
    -- Only needed so its bundled lsp/*.lua default configs exist for
    -- vim.lsp.enable() to pick up; nvim 0.11+ uses vim.lsp.config/enable
    -- natively instead of nvim-lspconfig's old setup() framework.
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      local servers = {
        "lua_ls",
        "bashls",
        "jsonls",
        "pyright",
        "ts_ls",
        "rust_analyzer",
      }

      require("mason-lspconfig").setup({
        ensure_installed = servers,
      })

      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
          end
          map("gd", vim.lsp.buf.definition, "Goto definition")
          map("gr", vim.lsp.buf.references, "Goto references")
          map("K", vim.lsp.buf.hover, "Hover docs")
          map("<leader>rn", vim.lsp.buf.rename, "Rename")
          map("<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
          map("]d", vim.diagnostic.goto_next, "Next diagnostic")
        end,
      })

      vim.lsp.enable(servers)
    end,
  },
}
