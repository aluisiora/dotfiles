{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  options = {
    programs.hyprland.caelestia.enable = lib.mkEnableOption "caelestia shell";
  };

  config = lib.mkIf config.programs.hyprland.caelestia.enable {
    services.upower.enable = true;
    services.gnome.gnome-keyring.enable = true;
    services.geoclue2.enable = true;

    environment.systemPackages = with inputs; [
      caelestia.packages.${pkgs.system}.with-cli
    ];
  };
}
