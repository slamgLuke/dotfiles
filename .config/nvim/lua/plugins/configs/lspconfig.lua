dofile(vim.g.base46_cache .. "lsp")
require "nvchad_ui.lsp"

local M = {}
local utils = require "core.utils"

-- export on_attach & capabilities for custom lspconfigs

M.on_attach = function(client, bufnr)
  utils.load_mappings("lspconfig", { buffer = bufnr })

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad_ui.signature").setup(client)
  end

  if not utils.load_config().ui.lsp_semantic_tokens then
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
          [vim.fn.stdpath "data" .. "/lazy/extensions/nvchad_types"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

-- CUSTOM

-- rust: rust_analyzer
lspconfig.rust_analyzer.setup({
    capabilities = M.capabilities,
    on_attach = M.on_attach,
    filetypes = {"rust"},
    root_dir = lspconfig.util.root_pattern("Cargo.toml"),
})

-- cpp: clangd
lspconfig.clangd.setup({
    capabilities = M.capabilities,
    on_attach = M.on_attach,
    M.capabilities.offsetEncoding == {"utf16"},
    cmd = {
        "/usr/bin/clandg",
        "-offset-encoding=utf-16",
    }
})

-- python: ruff
lspconfig.ruff_lsp.setup({
    capabilities = M.capabilities,
    on_attach = M.on_attach,
})

-- webdevel: emmet_ls
lspconfig.emmet_ls.setup({
    capabilities = M.capabilities,
    on_attach = M.on_attach,
    filetypes = {"css", "html", "javascript", "javascriptreact", "typescriptreact"},
    init_options = {
      html = {
        options = {
          -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
          ["bem.enabled"] = true,
        },
      },
    }
})

-- python: ruff
lspconfig.tailwindcss.setup({
    capabilities = M.capabilities,
    on_attach = M.on_attach,
})


-- latex: texlab (lsp) + latexindent (formatter)
lspconfig.texlab.setup({
    capabilities = M.capabilities,
    on_attach = M.on_attach,
})


return M
