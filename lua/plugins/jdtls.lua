return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      group = vim.api.nvim_create_augroup("jdtls", { clear = true }),
      callback = function()
        local nvim_data = vim.fn.stdpath("data") .. "/jdtls"
        local jdtls_path = vim.fn.fnamemodify(vim.fn.exepath("jdtls"), ":p:h") .. "/../share/java/jdtls"

        local root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew", "pom.xml" })
        if root_dir == nil or root_dir == vim.env.HOME then
          root_dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
        end

        local install_path = vim.fs.find(function(name, _)
          return name:match("org.eclipse.equinox.launcher_%w+")
        end, { path = jdtls_path .. "/plugins/" })[1]

        local uname = vim.uv.os_uname()
        local os = ""
        if uname.sysname == "Darwin" then
          os = "_mac"
        elseif uname.sysname == "Windows_NT" then
          os = "_win"
        elseif uname.sysname == "Linux" then
          os = "_linux"
        end

        -- jdtls wants the config path to be mutable so I symlink the config file in a new config directory
        vim.uv.fs_symlink(jdtls_path .. "/config" .. os .. "/config.ini", nvim_data .. "/config/config.ini")
        local config_path = nvim_data .. "/config"

        -- should probably serialize the whole dirname to avoid collisions
        local data_path = nvim_data .. vim.fn.fnamemodify(root_dir or "", ":p:h:t")

        require("jdtls").start_or_attach({
          -- The command that starts the language server
          -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
          cmd = {
            "java", -- assuming java is in PATH
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

          -- Here you can configure eclipse.jdt.ls specific settings
          -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
          -- for a list of options
          settings = {
            java = {},
          },

          -- Language server `initializationOptions`
          -- You need to extend the `bundles` with paths to jar files
          -- if you want to use additional eclipse.jdt.ls plugins.
          --
          -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
          --
          -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
          init_options = {
            bundles = {},
          },

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

            map("n", "lev", function()
              require("jdtls").extract_variable()
            end, { desc = "Extract Variable" })
            map("n", "lec", function()
              require("jdtls").extract_constant()
            end, { desc = "Extract Constant" })
            map("n", "lem", function()
              require("jdtls").extract_method()
            end, { desc = "Extract Method" })
          end,
        })
      end,
    })
  end,
}
