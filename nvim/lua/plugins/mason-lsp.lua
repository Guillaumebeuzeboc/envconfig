-- local clangd = require "lazyvim.plugins.extras.lang.clangd"
return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    {
      "mason-org/mason.nvim",
      opts = {
        ensure_installed = {
          "actionlint",
          "bash-language-server",
          "clangd",
          "copilot-language-server",
          "gopls",
          "json-lsp",
          "lua-language-server",
          "mypy",
          "pydocstyle",
          "pyflakes",
          "pylint",
          "pyright",
          "python-lsp-server",
          "rust-analyzer",
          "yaml-language-server",
        },
      },
    },
    "neovim/nvim-lspconfig",
    opts = {},
  },
  opts= {},
}
