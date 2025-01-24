local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettierd" },
    html = { "prettierd" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    javascriptreact = { "prettierd" },
    python={"isort","black"},
    go={"gofumpt" }
  },
  formatters = {
    black = {
      prepend_args = {
          "--fast",
          "--line-length",
          "80",
        },
      },
      sort = {
          prepend_args = {
            "--profile",
            "black",
      },
    },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

require("conform").setup(options)
