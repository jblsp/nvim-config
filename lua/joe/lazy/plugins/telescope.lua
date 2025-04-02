return {
  "nvim-telescope/telescope.nvim",
  -- version = "*", -- updates to LSP features are not in latest tag
  cmd = "Telescope",
  dependencies = {
    -- Dependencies
    { "nvim-lua/plenary.nvim", version = "*" },
    "nvim-tree/nvim-web-devicons",

    -- Extensions
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-ui-select.nvim",
    "debugloop/telescope-undo.nvim",
  },
  keys = function()
    ---@param picker string
    local function builtin(picker)
      return function()
        require("telescope.builtin")[picker]()
      end
    end

    ---@param extension string
    ---@param picker string
    local function ext(extension, picker)
      return function()
        require("telescope").extensions[extension][picker]()
      end
    end

    ---@param picker string
    local function custom(picker)
      return function()
        vim.g.telescope_custom_pickers[picker]()
      end
    end

    return {
      { "<leader>sh", builtin("help_tags"), desc = "Search help" },
      { "<leader>sk", builtin("keymaps"), desc = "Search keymaps" },
      { "<leader>sf", builtin("find_files"), desc = "Search files" },
      { "<leader>sw", builtin("grep_string"), desc = "Grep current word" },
      { "<leader>sg", builtin("live_grep"), desc = "Grep cwd" },
      { "<leader>bs", builtin("buffers"), desc = "Search buffers" },
      { "<leader>/", builtin("current_buffer_fuzzy_find"), desc = "Fuzzily search buffer" },
      { "<leader>sc", builtin("colorscheme"), desc = "Search colorschemes" },
      { "z=", builtin("spell_suggest"), desc = "Spelling suggestions" },
      { "gri", builtin("lsp_implementations"), desc = "View implementation" },
      { "g0", builtin("lsp_document_symbols"), desc = "View document symbols" },
      { "grr", builtin("lsp_references"), desc = "View references" },
      { "<leader>sn", custom("find_config_files"), desc = "Search config files" },
      { "<leader>sN", custom("find_config_directories"), desc = "Search config " },
      { "<leader>sG", custom("live_grep_open_buffers"), desc = "Grep open buffers" },
      { "<leader>sd", custom("find_directories"), desc = "Search directories" },
      { "<leader>u", ext("undo", "undo"), desc = "Undo History" },
    }
  end,
  init = function()
    ---@type table
    vim.g.telescope_custom_pickers = {}

    ---@param name string
    ---@param picker function
    local function custom_picker(name, picker)
      vim.g.telescope_custom_pickers = vim.tbl_deep_extend("force", vim.g.telescope_custom_pickers, {
        [name] = function()
          local telescope_modules = {
            builtin = require("telescope.builtin"),
          }
          picker(telescope_modules)
        end,
      })
    end

    custom_picker("live_grep_open_buffers", function(tm)
      tm.builtin.live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
      })
    end)

    custom_picker("find_directories", function(tm)
      tm.builtin.find_files({
        find_command = { "fd", "-t", "d" },
        previewer = false,
      })
    end)

    custom_picker("find_config_files", function(tm)
      tm.builtin.find_files({
        cwd = vim.fn.stdpath("config"),
      })
    end)

    custom_picker("find_config_directories", function(tm)
      tm.builtin.find_files({
        cwd = vim.fn.stdpath("config"),
        find_command = { "fd", "-t", "d" },
        previewer = false,
      })
    end)
  end,
  opts = function(_, _)
    local themes = require("telescope.themes")

    return {
      defaults = {
        scroll_strategy = "limit",
        mappings = {
          n = {
            ["q"] = "close",
            ["<C-u>"] = "results_scrolling_up",
            ["<C-d>"] = "results_scrolling_down",
            ["<C-b>"] = "results_scrolling_up",
            ["<C-f>"] = "results_scrolling_down",
          },
        },
      },
      pickers = {
        buffers = themes.get_dropdown({
          initial_mode = "normal",
          sort_mru = true,
          previewer = false,
        }),
        spell_suggest = themes.get_dropdown({
          initial_mode = "normal",
        }),
        current_buffer_fuzzy_find = themes.get_ivy({
          layout_config = { height = 0.35, bottom_pane = { preview_width = 0.25 } },
        }),
      },
    }
  end,
  config = function(_, opts)
    ---@type string[]
    local extensions = {}

    ---@param ext string
    ---@param ext_opts table?
    local function setup_extension(ext, ext_opts)
      opts.extensions = opts.extensions or {}
      if ext_opts then
        opts.extensions = vim.tbl_deep_extend("force", opts.extensions, { [ext] = ext_opts })
      end
      extensions = vim.fn.insert(extensions, ext)
    end

    local function setup_telescope()
      require("telescope").setup(opts)
      for _, ext in ipairs(extensions) do
        require("telescope").load_extension(ext)
      end
    end

    setup_extension("ui-select", require("telescope.themes").get_dropdown({}))
    setup_extension("fzf")
    setup_extension("undo", {
      use_delta = false,
      layout_config = {
        horizontal = {
          width = 0.85,
          preview_width = 0.7,
        },
      },
    })

    setup_telescope()
  end,
}
