{
  pkgs,
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.services.desktopManager.gnome.enable {
    environment.variables = {
      NIXOS_OZONE_WL = "1";
      SDL_VIDEODRIVER = "wayland";
      QT_QPA_PLATFORM = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      USE_WAYLAND_GRIM = "1";
    };

    services.gnome.games.enable = false;
    services.gnome.core-developer-tools.enable = false;

    qt = {
      enable = true;
      platformTheme = "gnome";
      style = "adwaita-dark";
    };

    services.udev.packages = with pkgs; [
      gnome-settings-daemon
    ];

    environment.systemPackages = with pkgs; [
      showtime
      gnome-tweaks
      gnomeExtensions.appindicator
      gnomeExtensions.paperwm
      gnomeExtensions.blur-my-shell
      gnomeExtensions.hibernate-status-button
      gnomeExtensions.keep-awake
      gnomeExtensions.rounded-window-corners-reborn
      deja-dup
    ];
    environment.gnome.excludePackages = with pkgs; [
      gnome-tour
      gnome-software
      gnome-contacts
      gnome-music
      gnome-maps
      epiphany
      simple-scan
      totem
      yelp
      geary
    ];
  };
}
