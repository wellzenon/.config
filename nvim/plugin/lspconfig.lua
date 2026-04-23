vim.pack.add({
  "https://github.com/folke/lazydev.nvim",
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/williamboman/mason-lspconfig.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  "https://github.com/j-hui/fidget.nvim",
})

-- vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })

require("mason").setup()

vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })

local lsps = {
  "gopls",
  "vtsls",
  "svelte",
  "tailwindcss",
  "terraformls",
  "dockerls",
  "jsonls",
  "yamlls",
  "pyright",
  "rust_analyzer",
  "marksman",
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        workspace = {
          checkThirdParty = false,
          library = { vim.env.VIMRUNTIME },
        },
        diagnostics = {
          globals = {
            "vim",
            "Snacks",
            "MiniStatusline",
          },
        },
        telemetry = { enable = false },
      },
    },
  },
}

for k, v in pairs(lsps) do
  if type(k) == "string" then
    vim.lsp.config(k, v)
    vim.lsp.enable(k)
  else
    vim.lsp.enable(v)
  end
end

-- vim.lsp.config("lua_ls", {
--   settings = {
--     Lua = {
--       runtime = { version = "LuaJIT" },
--       workspace = {
--         checkThirdParty = false,
--         library = { vim.env.VIMRUNTIME },
--       },
--       diagnostics = {
--         globals = {
--           "vim",
--           "Snacks",
--           "MiniStatusline",
--         },
--       },
--       telemetry = { enable = false },
--     },
--   },
-- })
--
-- vim.lsp.enable({ -- :MasonInstall gopls vtsls svelte-language-server tailwindcss-language-server terraform-ls dockerfile-language-server json-lsp yaml-language-server lua-language-server prettierd goimports stylua
--   "gopls", --   terraform-ls dockerfile-language-server json-lsp yaml-language-server
--   "vtsls", --   lua-language-server prettierd goimports stylua
--   "svelte",
--   "tailwindcss",
--   "terraformls",
--   "dockerls",
--   "jsonls",
--   "yamlls",
--   "lua_ls",
--   "pyright",
--   "rust_analyzer",
--   "marksman",
-- })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),

  callback = function(event)
    -- NOTE: Remember that Lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself.

    local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end

    if client:supports_method("textDocument/documentHighlight") then
      local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })
    end

    vim.diagnostic.config({
      severity_sort = true,
      float = { border = "rounded", source = "if_many" },
      underline = { severity = vim.diagnostic.severity.ERROR },
      signs = vim.g.have_nerd_font and {
        text = {
          [vim.diagnostic.severity.ERROR] = "󰅚 ",
          [vim.diagnostic.severity.WARN] = "󰀪 ",
          [vim.diagnostic.severity.INFO] = "󰋽 ",
          [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
      } or {},
      virtual_text = {
        source = "if_many",
        spacing = 2,
        format = function(diagnostic)
          local diagnostic_message = {
            [vim.diagnostic.severity.ERROR] = diagnostic.message,
            [vim.diagnostic.severity.WARN] = diagnostic.message,
            [vim.diagnostic.severity.INFO] = diagnostic.message,
            [vim.diagnostic.severity.HINT] = diagnostic.message,
          }
          return diagnostic_message[diagnostic.severity]
        end,
      },
    })

    vim.api.nvim_create_autocmd("LspDetach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
      callback = function(event2)
        vim.lsp.buf.clear_references()
        pcall(vim.api.nvim_clear_autocmds, { group = "kickstart-lsp-highlight", buffer = event2.buf })
      end,
    })
  end,
})
