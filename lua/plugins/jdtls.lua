return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      group = vim.api.nvim_create_augroup("jdtls", { clear = true }),
      callback = function()
        if vim.fn.executable("java") == 0 then
          vim.notify("Missing JRE, jdtls cannot attach", vim.log.levels.WARN)
          return
        end

        local cache_path = vim.fn.stdpath("cache") .. "/jdtls"
        local config_path = cache_path .. "/config"
        local jdtls_path = vim.fn.fnamemodify(vim.fn.exepath("jdtls"), ":p:h") .. "/../share/java/jdtls"

        -- this should be changed to retrieve the root with the root function from lspconfig
        local root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew", "pom.xml" })
        if root_dir == nil or root_dir == vim.env.HOME then
          root_dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
        end

        local install_path = vim.fs.find(function(name, _)
          return name:match("org.eclipse.equinox.launcher_%w+")
        end, { path = jdtls_path .. "/plugins/" })[1]

        local uname = vim.uv.os_uname()
        if uname.sysname == "Darwin" then
          os = "_mac"
        elseif uname.sysname == "Windows_NT" then
          os = "_win"
        elseif uname.sysname == "Linux" then
          os = "_linux"
        else
          os = ""
        end

        -- jdtls wants the config path to be mutable (this fixes jdtls installed by nix)
        -- TODO: jdtls still breaks on first launch so i think this function is running asynchronously
        vim.uv.fs_symlink(jdtls_path .. "/config" .. os .. "/config.ini", config_path .. "/config.ini")

        -- should probably serialize the whole dirname to avoid collisions
        local project_hash = vim.base64.encode(root_dir)
        local data_path = cache_path .. "/projects/" .. project_hash

        require("jdtls").start_or_attach({
          cmd = {
            "java",
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true",
            "-Dlog.level=ALL",
            "-Xmx1g",
            "--add-modules=ALL-SYSTEM",
            "--add-opens",
            "java.base/java.util=ALL-UNNAMED",
            "--add-opens",
            "java.base/java.lang=ALL-UNNAMED",
            "-jar",
            install_path,
            "-configuration",
            config_path,
            "-data",
            data_path,
          },

          root_dir = root_dir,

          on_attach = function(_, bufnr)
            vim.api.nvim_create_autocmd("LspRequest", {
              buffer = bufnr,
              callback = function(args)
                if args.data.request.method == "textDocument/formatting" then
                  local ftype = vim.api.nvim_get_option_value("filetype", { buf = args.buf })
                  if ftype == "java" then
                    require("jdtls").organize_imports()
                  end
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
