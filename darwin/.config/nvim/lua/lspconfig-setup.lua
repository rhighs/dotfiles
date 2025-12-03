local cmp = require("cmp")

cmp.setup({
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = "nvim_lsp" },
  },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
pcall(function()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
end)

vim.lsp.config("tsserver", {
  capabilities = capabilities,
})

vim.lsp.config("rust_analyzer", {
  capabilities = capabilities,
  settings = { ["rust-analyzer"] = {} },
})

vim.lsp.config("pyright", {
  capabilities = capabilities,
})

vim.lsp.config("lua_ls", {
  capabilities = capabilities,
})

vim.lsp.config("clangd", {
  capabilities = capabilities,
  cmd = { "clangd", "--background-index", "--clang-tidy" },
})

vim.lsp.enable("tsserver")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("pyright")
vim.lsp.enable("lua_ls")
vim.lsp.enable("clangd")

vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename)
vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<space>f", function()
  vim.lsp.buf.format({ async = true })
end)
