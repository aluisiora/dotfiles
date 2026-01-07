{
  config,
  lib,
  pkgs,
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
  
  environment.systemPackages = with pkgs; [
    asdbctl
    brightnessctl
  ];

  services.udev.extraRules = ''
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="05ac", ATTRS{idProduct}=="1114", MODE="0666", GROUP="video"
  '';

  systemd.tmpfiles.rules = lib.mkIf config.services.displayManager.gdm.enable [
    "L+ /run/gdm/.config/monitors.xml - - - - ${./monitors.xml}"
  ];
}
