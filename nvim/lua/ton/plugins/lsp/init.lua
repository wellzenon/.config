local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "ton.plugins.lsp.lsp-installer"
require("ton.plugins.lsp.handlers").setup()
require "ton.plugins.lsp.null-ls"
