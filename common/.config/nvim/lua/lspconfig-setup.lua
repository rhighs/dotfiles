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
    { name = "buffer" },
    { name = "path" },
  },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
pcall(function()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
end)

-- Per-server configuration via nvim-lspconfig
-- mason-lspconfig with automatic_enable=true will call vim.lsp.enable() for each installed server.
-- We just need to set any custom settings here.

vim.lsp.config("rust_analyzer", {
  capabilities = capabilities,
  settings = { ["rust-analyzer"] = {} },
})

vim.lsp.config("lua_ls", {
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = {
        checkThirdParty = false,
        -- Only add Neovim runtime when working inside the Neovim config dir.
        -- For other Lua projects (Kong, etc.) use a per-project .luarc.json.
        library = (function()
          local cwd = vim.fn.getcwd()
          if cwd:find(vim.fn.stdpath("config"), 1, true) then
            return { vim.env.VIMRUNTIME }
          end
          return {}
        end)(),
      },
      diagnostics = {
        globals = (function()
          local cwd = vim.fn.getcwd()
          if cwd:find(vim.fn.stdpath("config"), 1, true) then
            return { "vim" }
          end
          return {}
        end)(),
      },
    },
  },
})

vim.lsp.config("clangd", {
  capabilities = capabilities,
  cmd = { "clangd", "--background-index", "--clang-tidy" },
})

-- LSP keymaps — only active when an LSP server is attached to the buffer
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set("n", "gd",        vim.lsp.buf.definition,     opts)
    vim.keymap.set("n", "gD",        vim.lsp.buf.declaration,    opts)
    vim.keymap.set("n", "gi",        vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr",        vim.lsp.buf.references,     opts)
    vim.keymap.set("n", "gy",        vim.lsp.buf.type_definition,opts)
    vim.keymap.set("n", "K",         vim.lsp.buf.hover,          opts)
    vim.keymap.set("n", "gh",        vim.lsp.buf.hover,          opts)
    vim.keymap.set("n", "<C-k>",     vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename,         opts)
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action,    opts)
    vim.keymap.set("n", "<space>f",  function()
      vim.lsp.buf.format({ async = true })
    end, opts)
    vim.keymap.set("n", "[d",        vim.diagnostic.goto_prev,   opts)
    vim.keymap.set("n", "]d",        vim.diagnostic.goto_next,   opts)
    vim.keymap.set("n", "<space>e",  vim.diagnostic.open_float,  opts)
  end,
})
