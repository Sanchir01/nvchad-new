return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require "configs.conform"
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
  },
  {
    "github/copilot.vim",
  },
  {
    "rmagatti/auto-session",
    lazy = false,

    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      log_level = "debug",
    },
    config = function()
      vim.o.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,localoptions"
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  {
    "stevearc/dressing.nvim",
    lazy = false,
    opts = {},
  },
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
        "eslint_d",
        "eslint-lsp",
        "gopls",
        "pyright",
        "js-debug-adapter",
        "eslint_d",
        "prettier",
        "mymy",
        "ruff",
        "gopls",
        "pyright",
        "node-debug2-adapter",
        "typescript-language-server",
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufWritePre", "BufReadPre" },
    config = function()
      require "configs.lint"
    end,
  },
  {
    "stevearc/dressing.nvim",
    lazy = false,
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  { "tpope/vim-fugitive" },
  { "rbong/vim-flog", dependencies = {
    "tpope/vim-fugitive",
  }, lazy = false },
  { "sindrets/diffview.nvim", lazy = false },
  {
    "ggandor/leap.nvim",
    lazy = false,
    config = function()
      require("leap").add_default_mappings(true)
    end,
  },
  {
    "folke/trouble.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = function()
      require("nvim-tree").setup {

        view = {
          adaptive_size = true,
        },
        renderer = {
          group_empty = true,
        },
      }
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      require "configs.lint"
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    requires = "kevinhwang91/promise-async",
    event = "VeryLazy",
    opts = {
      open_fold_hl_timeout = 400,
      preview = {
        win_config = {
          border = { "", "─", "", "", "", "─", "", "" },
          winblend = 0,
        },
        mappings = {
          scrollU = "<C-u>",
          scrollD = "<C-d>",
          jumpTop = "[",
          jumpBot = "]",
        },
      },
    },
    config = function(_, opts)
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local totalLines = vim.api.nvim_buf_line_count(0)
        local foldedLines = endLnum - lnum
        local suffix = ("  %d %d%%"):format(foldedLines, foldedLines / totalLines * 100)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        local rAlignAppndx = math.max(math.min(vim.opt.textwidth["_value"], width - 1) - curWidth - sufWidth, 0)
        suffix = (" "):rep(rAlignAppndx) .. suffix
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end
      opts["fold_virt_text_handler"] = handler
      require("ufo").setup(opts)

      vim.fn.sign_define("FoldClosed", { text = "▸", texthl = "Folded" })
      vim.fn.sign_define("FoldOpen", { text = "▾", texthl = "Folded" })
      vim.fn.sign_define("FoldSeparator", { text = " ", texthl = "Folded" })
    end,
  },
  {
    "kevinhwang91/promise-async",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    ensure_installed = {
      "vim",
      "lua",
      "html",
      "css",
      "javascript",
      "typescript",
      "tsx",
      "python",
      "c",
      "markdown",
      "markdown_inline",
      "prisma",
      "vue",
      "go",
      "rust"
    },
    highlight = { enable = true },
    fold = { enable = true },
    indent = {
      enable = true,
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    config = function()
      require("todo-comments").setup()
    end,
  },
}
