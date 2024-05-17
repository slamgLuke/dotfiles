-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- typescript
lspconfig.tsserver.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

--
-- custom
--

-- rust: rust_analyzer + rustfmt
lspconfig.rust_analyzer.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "rust" },
  root_dir = lspconfig.util.root_pattern "Cargo.toml",
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
        enable = true,
      },
    },
  },
}

-- cpp: clangd
lspconfig.clangd.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  capabilities.offsetEncoding == { "utf16" },
  cmd = {
    "/home/lucas/.local/share/nvim/mason/bin/clangd",
    "-offset-encoding=utf-16",
  },
}

local custom_servers = {
  gopls = {},
  biome = {},
  ruff_lsp = {},
  asm_lsp = {},
  lua_ls = {},
}

for server, config in pairs(custom_servers) do
  config.capabilities = capabilities
  config.on_attach = on_attach
  lspconfig[server].setup(config)
end
