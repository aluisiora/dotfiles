{
  pkgs,
  lib,
  config,
  ...
}:
let
  sddm-astronaut-theme = pkgs.sddm-astronaut.override {
    # Themes: https://github.com/Keyitdev/sddm-astronaut-theme/tree/master/Themes
    embeddedTheme = config.services.displayManager.sddm.astronaut-embedded-theme;
  };
in
{
  options = {
    services.displayManager.sddm.astronaut-embedded-theme = lib.mkOption {
      type = lib.types.anything;
      default = "astronaut";
      description = "SDDM astronaut theme variant";
    };
  };

  config = lib.mkIf config.services.displayManager.sddm.enable {
    # Set cursor and turn display off
    services.xserver.displayManager.setupCommands = ''
      # Load cursor settings into the X server's resource database
      ${pkgs.xorg.xrdb}/bin/xrdb -merge - <<EOF
      Xcursor.theme: BreezeX-RosePine-Linux
      Xcursor.size: 48
      EOF

      ${pkgs.xorg.xset}/bin/xset s 30 30
      ${pkgs.xorg.xset}/bin/xset dpms 30 30 30
    '';
    services.displayManager.sddm = {
      theme = "sddm-astronaut-theme";
      package = pkgs.kdePackages.sddm;
      extraPackages = with pkgs; [
        kdePackages.qtsvg
        kdePackages.qtmultimedia
        kdePackages.qtvirtualkeyboard
      ];
    };

    environment.systemPackages = with pkgs; [
      rose-pine-cursor
      xorg.xrdb
      sddm-astronaut-theme
    ];
  };
}
