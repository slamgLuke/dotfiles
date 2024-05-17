local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    python = { "black" },
    cpp = { "clang_format" },
    c = { "clang_format" },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

require("conform").setup(options)

require("conform").formatters = {
  c = {
    prepend_args = {
      "-style=file",
    },
  },
  cpp = {
    prepend_args = {
      "-style=file",
    },
  },
}
