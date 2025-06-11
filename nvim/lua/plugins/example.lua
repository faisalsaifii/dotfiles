return {
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },

  -- {
  --   "github/copilot.vim",
  -- },

  { "folke/trouble.nvim", enabled = false },

  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
    },
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      servers = {
        pyright = {},
        hls = {
          formattingProvider = "ormolu",
          cabalFormattingProvider = "cabalfmt",
        },
        rescriptls = {},
        tailwindcss = {},
      },
    },
  },

  {
    "APZelos/blamer.nvim",
  },
  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = true },
  },
  -- add tsserver and setup with typescript.nvim instead of lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      servers = {
        -- tsserver will be automatically installed with mason and loaded with lspconfig
        tsserver = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      setup = {
        -- example to setup with typescript.nvim
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },

  { import = "lazyvim.plugins.extras.lang.typescript" },

  {
    "nvim-treesitter/nvim-treesitter-context",
  },

  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  {
    "APZelos/blamer.nvim",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "rescript",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
      })
    end,
  },

  -- {
  --   "nvim-lualine/lualine.nvim",
  --   event = "VeryLazy",
  --   opts = function()
  --     return {
  --       --[[add your custom lualine config here]]
  --       icons_enabled = true,
  --     }
  --   end,
  -- },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "folke/tokyonight.nvim" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "tokyonight",
          icons_enabled = true,
          -- section_separators = "",
          -- component_separators = "",
        },
      })

      -- Function to clear lualine backgrounds
      local function clear_lualine_bg()
        local groups = {
          -- "lualine_a_normal",
          -- "lualine_b_normal",
          "lualine_c_normal",
          -- "lualine_a_insert",
          -- "lualine_b_insert",
          "lualine_c_insert",
          -- "lualine_a_visual",
          -- "lualine_b_visual",
          "lualine_c_visual",
          -- "lualine_a_replace",
          -- "lualine_b_replace",
          "lualine_c_replace",
          -- "lualine_a_command",
          -- "lualine_b_command",
          "lualine_c_command",
          -- "lualine_a_inactive",
          -- "lualine_b_inactive",
          "lualine_c_inactive",
        }
        for _, group in ipairs(groups) do
          vim.api.nvim_set_hl(0, group, { bg = "NONE" })
        end
      end

      -- Clear lualine backgrounds immediately after colorscheme loads
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "tokyonight",
        callback = clear_lualine_bg,
      })

      -- Also clear on initial load
      clear_lualine_bg()
    end,
  },
  { import = "lazyvim.plugins.extras.lang.json" },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },
}
