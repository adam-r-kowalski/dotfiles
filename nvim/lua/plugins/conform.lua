return {
  'stevearc/conform.nvim',
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      opts = {
        ensure_installed = { "stylua", "black", "prettier" },
      }
    }
  },
  opts = {
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
    },
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "black" },
      javascript = { "prettier" },
    }
  },
}
