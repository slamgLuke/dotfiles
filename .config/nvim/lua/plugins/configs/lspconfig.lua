dofile(vim.g.base46_cache .. "lsp")
require "nvchad.lsp"

local M = {}
local utils = require "core.utils"

-- export on_attach & capabilities for custom lspconfigs

M.on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  utils.load_mappings("lspconfig", { buffer = bufnr })

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad.signature").setup(client)
  end

  if not utils.load_config().ui.lsp_semantic_tokens and client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

local lspconfig = require("lspconfig")

-- lua
lspconfig.lua_ls.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,

  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}


-- 
-- custom
--

-- rust: rust_analyzer
lspconfig.rust_analyzer.setup({
  capabilities = M.capabilities,
  on_attach = M.on_attach,
  filetypes = {"rust"},
  root_dir = lspconfig.util.root_pattern("Cargo.toml"),
  settings = {
    ["rust-analyzer"] = {
      imports = {
        granularity = {
          group = "module",
        },
        prefix = "self",
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true
      },
    }
  },
})

-- cpp: clangd
lspconfig.clangd.setup({
  capabilities = M.capabilities,
  on_attach = M.on_attach,
  M.capabilities.offsetEncoding == {"utf16"},
  cmd = {
    "/home/lucas/.local/share/nvim/mason/packages/clangd/clangd_17.0.3/bin/clangd",
    "-offset-encoding=utf-16",
  },
})

-- go: gopls
lspconfig.gopls.setup({
  capabilites = M.capabilites,
  on_attach = M.on_attach,
})

-- js/ts/json: biome
lspconfig.biome.setup({
  capabilities = M.capabilites,
  on_attach = M.on_attach,
})

-- python: ruff-lsp + black
lspconfig.ruff_lsp.setup({
  capabilities = M.capabilites,
  on_attach = M.on_attach,
})

return M
