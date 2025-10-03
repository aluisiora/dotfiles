{
  config,
  lib,
  ...
}:
{
  services.xserver.dpi = 218;
  services.displayManager.sddm.enableHidpi = true;

  fonts.fontconfig = {
    enable = true;
    hinting.enable = false;
    subpixel.lcdfilter = "none";
    subpixel.rgba = "none";
  };

  hardware.i2c.enable = true;

  systemd.tmpfiles.rules = lib.mkIf config.services.displayManager.gdm.enable [
    "L+ /run/gdm/.config/monitors.xml - - - - ${./monitors.xml}"
  ];
}
