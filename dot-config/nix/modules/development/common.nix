{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
let
  system = pkgs.stdenv.hostPlatform.system;
  worktrunk = inputs.worktrunk.packages.${system}.default;
in
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
      delta
      devbox
      devenv
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
      sqlite
      stow
      stylua
      tokei
      tldr
      tmux
      tree-sitter
      usql
      wget
      worktrunk
      yazi
      yq
      zoxide
    ];
  };
}
