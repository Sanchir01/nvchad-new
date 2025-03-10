local configs = require "nvchad.configs.lspconfig"

local on_attach = configs.on_attach
local on_init = configs.on_init
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers =
  { "html", "cssls", "ts_ls", "clangd", "gopls", "gradle_ls", "volar", "prismals", "graphql", "tailwindcss", "pyright" ,"rust_analyzer","emmet_language_server"}

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
  }
  vim.lsp.buf.execute_command(params)
end 

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    commands = {
      OrganizeImports = {
        organize_imports,
        description = "Organize Imports",
      },
    },
    settings = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = true,
        analyses = {
          unusedparams = true,
        },
      },
    },
  }
  lspconfig.graphql.setup {
    filetypes = { "graphql", "graphqls" },
    settings = {
      graphql = {
        validate = true,
      },
    },
  }
    lspconfig.emmet_language_server.setup {
     filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact" },
  init_options = {
    ---@type table<string, string>
    includeLanguages = {},
    --- @type string[]
    excludeLanguages = {},
    --- @type string[]
    extensionsPath = {},
    --- @type table<string, any> 
    preferences = {},
    --- @type boolean 
    showAbbreviationSuggestions = true,
    --- @type "always" | "never"
    showExpandedAbbreviation = "always",
    --- @type boolean 
    showSuggestionsAsSnippets = false,
    --- @type table<string, any> 
    syntaxProfiles = {},
    --- @type table<string, string> 
    variables = {},
  },
  }
  lspconfig.pyright.setup {
    filetypes = { "python", "py" },
    settings = {
      python = {
        pythonPath = ".venv/**/python.exe",
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "workspace",
        },
      },
    },
  }
  lspconfig.prismals.setup {}
  lspconfig.volar.setup {
    filetypes = { "vue" },
    init_options = {
      vue = {
        hybridMode = false,
      },
    },
  }
  lspconfig.tailwindcss.setup {
    settings = {
      tailwindCSS = {
        experimental = {
          classRegex = {
            { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" }, -- для динамических классов
          },
        },
      },
    },
    filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact", "vue" },
  }
end
