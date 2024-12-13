return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    "nvim-telescope/telescope-frecency.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    "nvim-telescope/telescope-symbols.nvim",
    "debugloop/telescope-undo.nvim",
  },

  opts = {
    defaults = {
      mappings = {
        n = {
          ["q"] = "close",
        },
      },
    },
    pickers = {
      buffers = {
        initial_mode = "normal",
        sort_mru = true,
        mappings = {
          n = {
            ["<c-d>"] = function(args)
              require("telescope.actions").delete_buffer(args)
            end,
            [";"] = "close",
          },
          i = {
            ["<c-d>"] = function(args)
              require("telescope.actions").delete_buffer(args)
            end,
          },
        },
      },
      spell_suggest = {
        initial_mode = "normal",
      },
    },
  },
  keys = {
    {
      "<leader>sh",
      function()
        require("telescope.builtin").help_tags()
      end,
      desc = "Search Help",
    },
    {
      "<leader>sk",
      function()
        require("telescope.builtin").keymaps()
      end,
      desc = "Search Keymaps",
    },
    {
      "<leader>sf",
      function()
        require("telescope.builtin").find_files()
      end,
      desc = "Search Files",
    },
    {
      "<leader>sF",
      function()
        require("telescope").extensions.frecency.frecency()
      end,
      desc = "Search Files (Frecency)",
    },
    {
      "<leader>st",
      function()
        require("telescope.builtin").builtin()
      end,
      desc = "Search Telescope Builtin",
    },
    {
      "gW",
      function()
        require("telescope.builtin").grep_string()
      end,
      desc = "Grep Current Word",
    },
    {
      "<leader>sg",
      function()
        require("telescope.builtin").live_grep({
          attach_mappings = function(_, map)
            map("n", "<C-a>", function()
              require("telescope").extensions.live_grep_args.live_grep_args()
            end)
            return true
          end,
        })
      end,
      desc = " Grep",
    },
    {
      "<leader>sd",
      function()
        require("telescope.builtin").diagnostics()
      end,
      desc = "Search Diagnostics",
    },
    {
      "<leader>sr",
      function()
        require("telescope.builtin").resume()
      end,
      desc = "Resume Previous Search",
    },
    {
      ";",
      function()
        local dropdown = require("telescope.themes").get_dropdown({ previewer = false, results_height = 20 })
        require("telescope.builtin").buffers(dropdown)
      end,
      desc = "Search Buffers",
    },
    {
      "<leader>/",
      function()
        local dropdown = require("telescope.themes").get_dropdown({
          previewer = false,
        })
        require("telescope.builtin").current_buffer_fuzzy_find(dropdown)
      end,
      desc = "Fuzzily Search in Current Buffer",
    },
    {
      "<leader>sn",
      function()
        require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Search Neovim Files",
    },
    {
      "<leader>sG",
      function()
        local opts = {
          grep_open_files = true,
          prompt_title = "Live Grep in Open Files",
        }
        opts = vim.tbl_deep_extend("force", opts, {
          attach_mappings = function(_, map)
            map("n", "<C-a>", function()
              opts.prompt_title = opts.prompt_title .. " (args)"
              require("telescope").extensions.live_grep_args.live_grep_args(opts)
            end)

            return true
          end,
        })
        require("telescope.builtin").live_grep(opts)
      end,
      desc = "Live Grep in Open Files",
    },
    {
      "z=",
      function()
        local dropdown = require("telescope.themes").get_dropdown({
          previewer = false,
        })
        require("telescope.builtin").spell_suggest(dropdown)
      end,
      desc = "Spelling suggestions",
    },
    {
      "<C-Space>e",
      function()
        require("telescope.builtin").symbols({ sources = { "emoji" } })
      end,
      mode = { "i", "n" },
      desc = "Insert emoji",
    },
    {
      "<C-Space>m",
      function()
        require("telescope.builtin").symbols({ sources = { "math" } })
      end,
      mode = { "i", "n" },
      desc = "Insert math symbol",
    },
    {
      "<C-Space>l",
      function()
        require("telescope.builtin").symbols({ sources = { "latex" } })
      end,
      mode = { "i", "n" },
      desc = "Insert latex symbol",
    },
    {
      "<C-Space>n",
      function()
        require("telescope.builtin").symbols({ sources = { "nerd" } })
      end,
      mode = { "i", "n" },
      desc = "Insert nerd symbol",
    },
    {
      "<leader>u",
      function()
        require("telescope").extensions.undo.undo()
      end,
      desc = "Undo History",
    },
    {
      "gd",
      function()
        require("telescope.builtin").lsp_definitions()
      end,
      desc = "Go to Definition",
    },
    {
      "gr",
      function()
        require("telescope.builtin").lsp_references()
      end,
      desc = "Go to References",
    },
    {
      "gI",
      function()
        require("telescope.builtin").lsp_implementations()
      end,
      desc = "Go to Implementation",
    },
    {
      "gy",
      function()
        require("telescope.builtin").lsp_type_definitions()
      end,
      desc = "Go to Type Definition",
    },
    {
      "<leader>ls",
      function()
        require("telescope.builtin").lsp_document_symbols()
      end,
      desc = "Document Symbols",
    },
    {
      "<leader>lS",
      function()
        require("telescope.builtin").lsp_dynamic_workspace_symbols()
      end,
      desc = "Workspace Symbols",
    },
  },
  config = function(_, opts)
    local extensions = {}
    local function setup_extension(ext, ext_opts)
      opts.extensions = opts.extensions or {}
      if ext_opts then
        opts.extensions = vim.tbl_deep_extend("force", {}, opts.extensions, { [ext] = ext_opts })
      end
      extensions = vim.fn.insert(extensions, ext)
    end
    local function setup_telescope()
      require("telescope").setup(opts)
      for _, ext in ipairs(extensions) do
        require("telescope").load_extension(ext)
      end
    end

    -- setup extensions
    setup_extension("ui-select", require("telescope.themes").get_dropdown({}))
    setup_extension("fzf")
    setup_extension("frecency", { show_filter_column = false, db_safe_mode = false, db_validate_threshold = 1 })
    setup_extension("undo", {
      use_delta = false,
      layout_config = {
        horizontal = {
          width = 0.8,
          preview_width = 0.7,
        },
      },
    })

    setup_telescope()
  end,
}
