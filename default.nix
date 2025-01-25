{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.neovim;
in {
  options.modules.neovim = {
    enable = lib.mkEnableOption "Enables neovim";
  };

  config = lib.mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      plugins = with pkgs.vimPlugins; [
        nvim-treesitter.withAllGrammars
      ];
      extraPackages = with pkgs; [
        # lazy.nvim dependencies
        git

        # Language servers
        lua-language-server
        pyright
        jdt-language-server
        haskell-language-server
        nixd

        # Formatters
        stylua
        black
        isort
        prettierd
        alejandra

        # Linters
        selene
        pylint
        markdownlint-cli2
      ];
    };
  };
}
