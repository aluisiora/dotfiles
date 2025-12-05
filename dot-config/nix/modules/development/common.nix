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
      git
      tmux
      neovim
      lazygit
      lazydocker
      stow
      atuin
      devenv
      devbox
      cargo
      nixd
      nixfmt-rfc-style
      lua51Packages.luarocks
      nodejs_24
      wget
      jq
      fzf
      fd
      ripgrep
      rsync
      diff-so-fancy
      difftastic
      carapace
      tldr
      zoxide
      posting
      mariadb.client
      sqlite
    ];
  };
}
