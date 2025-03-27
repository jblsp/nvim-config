return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      group = vim.api.nvim_create_augroup("jdtls", { clear = true }),
      callback = function()
        local root_dir =
          vim.fs.root(0, { ".git", "mvnw", "gradlew", "pom.xml", "settings.gradle", "settings.gradle.ks" })

        local proj_args
        if root_dir then
          local proj_cache_path = vim.fn.stdpath("cache") .. "/jdtls/" .. vim.fs.basename(root_dir)
          proj_args = {
            "-configuration",
            proj_cache_path .. "/config",
            "-data",
            proj_cache_path .. "/data",
          }
        end

        require("jdtls").start_or_attach({
          cmd = vim.list_extend({ vim.fn.exepath("jdtls") }, proj_args),

          root_dir = root_dir,

          on_attach = function(_, bufnr)
            vim.api.nvim_create_autocmd("LspRequest", {
              buffer = bufnr,
              callback = function(args)
                if args.data.request.method == "textDocument/formatting" then
                  require("jdtls").organize_imports()
                end
              end,
            })

            local function map(mode, lhs, rhs, opts)
              opts = opts or {}
              opts.buffer = bufnr
              opts.desc = "jdtls: " .. opts.desc
              vim.keymap.set(mode, lhs, rhs, opts)
            end

            -- stylua: ignore start
            map("n", "<localleader>ev", function() require("jdtls").extract_variable() end, { desc = "Extract Variable" })
            map("n", "<localleader>ec", function() require("jdtls").extract_constant() end, { desc = "Extract Constant" })
            map("n", "<localleader>em", function() require("jdtls").extract_method() end, { desc = "Extract Method" })
            -- stylua: ignore end
          end,
        })
      end,
    })
  end,
}
