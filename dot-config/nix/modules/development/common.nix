{
  pkgs,
  config,
  lib,
  ...
}:
{
  options = {
    development.enable = lib.mkEnableOption "development utilities";
  };

  config = lib.mkIf config.development.enable {
    programs.direnv.enable = true;
    programs.direnv.silent = true;
    environment.systemPackages = with pkgs; [
      atuin
      bat
      carapace
      cargo
      devbox
      devenv
      diff-so-fancy
      difftastic
      fd
      fixjson
      fzf
      gemini-cli
      git
      hadolint
      jq
      lazydocker
      lazygit
      libxml2
      lua51Packages.luacheck
      lua51Packages.luarocks
      mariadb.client
      neovim
      nixd
      nixfmt
      nodejs_24
      posting
      ripgrep
      rsync
      sqlite
      stow
      stylua
      tldr
      tmux
      tree-sitter
      usql
      wget
      yazi
      yq
      zoxide
    ];
  };
}
