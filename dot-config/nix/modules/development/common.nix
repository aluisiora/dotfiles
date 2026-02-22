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
      cloc
      devbox
      devenv
      diff-so-fancy
      difftastic
      fd
      fixjson
      fzf
      git
      hadolint
      hurl
      jq
      lazydocker
      lazygit
      libxml2
      lua51Packages.luacheck
      lua51Packages.luarocks
      mariadb.client
      mise
      neovim
      nixd
      nixfmt
      nodejs_24
      ripgrep
      rsync
      sesh
      sqlite
      stow
      stylua
      tokei
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
