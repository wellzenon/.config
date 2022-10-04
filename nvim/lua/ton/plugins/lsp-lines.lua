local status_ok, lsp_lines = pcall(require, "lsp_lines")
if not status_ok then
  return
  print("lsp_lines not found")
end

lsp_lines.setup()
