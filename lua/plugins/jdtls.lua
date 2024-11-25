return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  config = function()
    local jdtls_mason_pkg = require("mason-registry").get_package("jdtls")
    if not jdtls_mason_pkg:is_installed() then
      jdtls_mason_pkg:install()
    end
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "java",
      group = vim.api.nvim_create_augroup("jdtls", { clear = true }),
      callback = function()
        local jdtls_path = jdtls_mason_pkg:get_install_path()

        local root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew", "pom.xml" })

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

        local arch = ""
        if uname.machine == "arm64" then
          arch = "_arm"
        end

        local config_path = jdtls_path .. "/config" .. os .. arch
        local workspace_path = vim.fn.stdpath("data")
          .. "/jdtls/workspaces/"
          .. vim.fn.fnamemodify(root_dir or "", ":p:h:t")

        require("jdtls").start_or_attach({
          -- The command that starts the language server
          -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
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
            workspace_path,
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
        })
      end,
    })
  end,
}
