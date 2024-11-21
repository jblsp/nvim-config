return {
  "folke/snacks.nvim",
  version = "*",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = {
      enabled = true,
      size = 5 * 1024 * 1024, -- 5MB
    },
    notifier = {
      enabled = true,
      timeout = 5000,
      width = { min = 35, max = 80 },
      margin = { top = 1, right = 2 },
      style = "minimal",
    },
    quickfile = { enabled = true },
  },
  keys = {
    {
      "<leader>rf",
      function()
        Snacks.rename.rename_file()
      end,
      desc = "Rename File",
    },
    {
      "<leader>bd",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete current buffer",
    },
    {
      "<leader>bD",
      function()
        Snacks.bufdelete.all()
      end,
      desc = "Delete all buffers",
    },
    {
      "<leader>bw",
      function()
        Snacks.bufdelete({ wipe = true })
      end,
      desc = "Wipeout current buffer",
    },
    {
      "<leader>bW",
      function()
        Snacks.bufdelete.all({ wipe = true })
      end,
      desc = "Wipeout all buffers",
    },
    {
      "<leader>gg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit",
    },
    {
      "<leader>gB",
      function()
        Snacks.gitbrowse()
      end,
      desc = "Git Browse",
    },
    {
      "<leader>gf",
      function()
        Snacks.lazygit.log_file()
      end,
      desc = "Lazygit Current File History",
    },
    {
      "<leader>gl",
      function()
        Snacks.lazygit.log()
      end,
      desc = "Lazygit Log (cwd)",
    },
    {
      "<leader>n",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "Notification History",
    },
  },
  init = function()
    local augroup = vim.api.nvim_create_augroup("Snacks", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      group = augroup,
      callback = function()
        vim.print = Snacks.debug.inspect

        -- mini.files integration
        vim.api.nvim_create_autocmd("User", {
          pattern = "MiniFilesActionRename",
          group = augroup,
          callback = function(event)
            Snacks.rename.on_rename_file(event.data.from, event.data.to)
          end,
        })

        -- LSP Progress
        ---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
        local progress = vim.defaulttable()
        vim.api.nvim_create_autocmd("LspProgress", {
          group = augroup,
          ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
          callback = function(ev)
            local client = vim.lsp.get_client_by_id(ev.data.client_id)
            local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
            if not client or type(value) ~= "table" then
              return
            end
            local p = progress[client.id]

            for i = 1, #p + 1 do
              if i == #p + 1 or p[i].token == ev.data.params.token then
                p[i] = {
                  token = ev.data.params.token,
                  msg = ("LSP: %s%s [%3d%%] "):format(
                    value.title or "",
                    value.message and (" **%s**"):format(value.message) or "",
                    value.kind == "end" and 100 or value.percentage or 100
                  ),
                  done = value.kind == "end",
                }
                break
              end
            end

            local msg = {} ---@type string[]
            progress[client.id] = vim.tbl_filter(function(v)
              return table.insert(msg, v.msg) or not v.done
            end, p)

            local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
            vim.notify(table.concat(msg, "\n"), "info", {
              id = "lsp_progress",
              title = client.name,
              opts = function(notif)
                notif.icon = #progress[client.id] == 0 and " "
                  or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
              end,
            })
          end,
        })
      end,
    })
  end,
}
