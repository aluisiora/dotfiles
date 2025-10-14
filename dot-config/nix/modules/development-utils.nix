{
  pkgs,
  config,
  lib,
  ...
}:
{
  options = {
    developmentUtils.enable = lib.mkEnableOption "development utilities";
  };

  config = lib.mkIf config.developmentUtils.enable {
    programs.direnv.enable = true;
    programs.direnv.silent = true;
    environment.systemPackages = with pkgs; [
      git
      tmux
      neovim
      lazygit
      stow
      devenv
      cargo
      nixd
      nixfmt-rfc-style
      lua51Packages.luarocks
      nodejs_24
      mysql-client
      wget
      jq
      fzf
      fd
      ripgrep
      rsync
      diff-so-fancy
      carapace
      tldr
      zoxide
      posting
    ];
  };
}
