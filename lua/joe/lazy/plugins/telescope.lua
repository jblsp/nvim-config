local custom_pickers

return {
  "nvim-telescope/telescope.nvim",
  version = "*",
  event = "VeryLazy",
  dependencies = {
    { "nvim-lua/plenary.nvim", version = "*" },
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope-ui-select.nvim",
    "debugloop/telescope-undo.nvim",
  },
  keys = function()
    local pickers = {
      builtin = function(picker)
        return function()
          require("telescope.builtin")[picker]()
        end
      end,
      ext = function(extension, picker)
        return function()
          require("telescope").extensions[extension][picker]()
        end
      end,
      custom = function(picker)
        return function()
          custom_pickers[picker]()
        end
      end,
    }

    return {
      { "<leader>sh", pickers.builtin("help_tags"), desc = "Search help" },
      { "<leader>sk", pickers.builtin("keymaps"), desc = "Search keymaps" },
      { "<leader>sf", pickers.builtin("find_files"), desc = "Search files" },
      { "<leader>sw", pickers.builtin("grep_string"), desc = "Grep current word" },
      { "<leader>sg", pickers.builtin("live_grep"), desc = "Grep cwd" },
      { "<leader>bs", pickers.builtin("buffers"), desc = "Search buffers" },
      { "<leader>/", pickers.builtin("current_buffer_fuzzy_find"), desc = "Fuzzily search buffer" },
      { "z=", pickers.builtin("spell_suggest"), desc = "Spelling suggestions" },
      { "<leader>sn", pickers.custom("find_config_files"), desc = "Search config files" },
      { "<leader>sG", pickers.custom("live_grep_open_buffers"), desc = "Grep open buffers" },
      { "<leader>sd", pickers.custom("find_directories"), desc = "Search directories" },
      { "<leader>u", pickers.ext("undo", "undo"), desc = "Undo History" },
    }
  end,
  opts = function(_, _)
    local themes = require("telescope.themes")

    return {
      defaults = {
        scroll_strategy = "limit",
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
        },
        spell_suggest = vim.tbl_deep_extend("force", themes.get_dropdown(), { initial_mode = "normal" }),
      },
    }
  end,
  config = function(_, opts)
    local builtin = require("telescope.builtin")

    custom_pickers = {
      ["live_grep_open_buffers"] = function()
        builtin.live_grep({
          grep_open_files = true,
          prompt_title = "Live Grep in Open Files",
        })
      end,
      ["find_config_files"] = function()
        builtin.find_files({
          cwd = vim.fn.stdpath("config"),
        })
      end,
      ["find_directories"] = function()
        builtin.find_files({
          find_command = { "fd", "-t", "d" },
          previewer = false,
        })
      end,
    }

    local extensions

    local function setup_extension(ext, ext_opts)
      opts.extensions = opts.extensions or {}
      if ext_opts then
        opts.extensions = vim.tbl_deep_extend("force", opts.extensions, { [ext] = ext_opts })
      end
      extensions = vim.fn.insert(extensions or {}, ext)
    end

    local function setup_telescope()
      require("telescope").setup(opts)
      for _, extn in ipairs(extensions) do
        require("telescope").load_extension(extn)
      end
    end

    setup_extension("ui-select", require("telescope.themes").get_dropdown({}))
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
