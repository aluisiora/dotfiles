{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    developmentUtils.enable = lib.mkEnableOption "development utilities";
  };

  config = lib.mkIf config.developmentUtils.enable {
    environment.variables = {
      DBX_CONTAINER_MANAGER = "docker";
    };
    programs.nix-ld.enable = true;
    programs.direnv.enable = true;
    programs.direnv.silent = true;
    virtualisation.docker.enable = true;
    virtualisation.docker.enableOnBoot = true;
    environment.systemPackages = with pkgs; [
      tmux
      neovim
      lazygit
      lazydocker
      yazi
      stow
      devenv
      gnumake
      gcc
      cargo
      nixd
      nixfmt-rfc-style
      lua51Packages.luarocks
      nodejs_24
      mysql-client
      coreutils
      findutils
      wget
      unzip
      zip
      rar
      jq
      fzf
      fd
      ripgrep
      rsync
      file
      diff-so-fancy
      carapace
      tldr
      zoxide
      posting
    ];
  };
}
