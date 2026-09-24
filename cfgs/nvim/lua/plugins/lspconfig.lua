return {
  -- Package manager to ensure servers are installed locally
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {
      ensure_installed = { "basedpyright", "ruff" },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end,
  },

  -- Still needed: acts as the text data/blueprints provider for vim.lsp.config
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      -- Native modern keymaps & events setup
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        end,
      })

      -- 1. Modify Basedpyright natively
      vim.lsp.config("basedpyright", {
        settings = {
          basedpyright = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "openFilesOnly",
              useLibraryCodeForTypes = true,
              typeCheckingMode = "basic",
            },
          },
        },
      })

      -- 2. Modify Ruff natively (prevent hover collision)
      vim.lsp.config("ruff", {
        on_attach = function(client, _)
          if client.name == "ruff" then
            client.server_capabilities.hoverProvider = false
          end
        end,
      })

      -- 3. Modern activation pattern
      vim.lsp.enable({ "basedpyright", "ruff" })
      
      -- 4. Native formatting on save via Ruff
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.py",
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end,
  },
}

