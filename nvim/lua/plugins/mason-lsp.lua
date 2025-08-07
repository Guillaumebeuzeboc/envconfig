-- local clangd = require "lazyvim.plugins.extras.lang.clangd"
return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    {
      "mason-org/mason.nvim",
      opts = {
        ensure_installed = {
          "actionlint",
          "lua-language-server",
          "rust-analyzer",
          "clangd",
          "pyright",
          "python-lsp-server",
          "pylint",
          "pydocstyle",
          "pyflakes",
          "gopls",
          "bash-language-server",
          "json-lsp",
          "yaml-language-server",
          "mypy",
        },
      },
    },
    "neovim/nvim-lspconfig",
    opts = {},
  },
  opts = {},
}
