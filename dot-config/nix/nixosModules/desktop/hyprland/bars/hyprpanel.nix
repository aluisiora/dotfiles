{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    programs.hyprland.hyprpanel.enable = lib.mkEnableOption "hyprpanel bar";
  };

  config = lib.mkIf config.programs.hyprland.hyprpanel.enable {
    environment.systemPackages = with pkgs; [
      hyprpanel
      hyprshot
      hyprlock
    ];
  };
}
