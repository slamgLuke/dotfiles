-- plugins/configs/null-ls.lua

local null_ls = require "null-ls"

local formatting = null_ls.builtins.formatting
-- local lint = null_ls.builtins.diagnostics

local sources = {
  formatting.black,
  formatting.clang_format.with { extra_args = { "-style=file" } },
  formatting.prettier,
  formatting.stylua,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
