local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local servers = {
  "sumneko_lua",
  "cssls",
  "html",
  "tsserver",
  "svelte",
  "pyright",
  "bashls",
  "jsonls",
  "yamlls",
}

lsp_installer.setup()

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("ton.plugins.lsp.handlers").on_attach,
    capabilities = require("ton.plugins.lsp.handlers").capabilities,
  }

  if server == "svelte" then
    local svelte_opts = require "ton.plugins.lsp.settings.svelte"
    opts = vim.tbl_deep_extend("force", svelte_opts, opts)
  end

  if server == "sumneko_lua" then
    local sumneko_opts = require "ton.plugins.lsp.settings.sumneko_lua"
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end

  if server == "pyright" then
    local pyright_opts = require "ton.plugins.lsp.settings.pyright"
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  lspconfig[server].setup(opts)
end