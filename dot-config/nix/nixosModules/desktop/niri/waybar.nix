{ pkgs, lib, config, ... }:
{
  options = {
    programs.niri.waybar.enable = lib.mkEnableOption "waybar configuration";
  };

  config = lib.mkIf config.programs.niri.waybar.enable {
    programs.waybar.enable = true;
    programs.nm-applet.enable = true;
    services.geoclue2.enable = true;

    environment.systemPackages = with pkgs; [
      mako
      fuzzel
      swww
      swaylock
      wl-clipboard
      cliphist
      pavucontrol
    ];
  };
}
