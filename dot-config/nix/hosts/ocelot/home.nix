{ pkgs, user, ... }:
{
  home.username = user;
  home.homeDirectory = "/home/${user}";
  home.packages = with pkgs; [
    slack
    gnome-boxes
    obsidian
  ];
  home.file = {};
  programs.ghostty.enable = true;
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "25.11";
}
