{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./waybar.nix
    ./dms.nix
  ];

  config = lib.mkIf config.programs.niri.enable {
    environment.variables = {
      NIXOS_OZONE_WL = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      SDL_VIDEODRIVER = "wayland";
      QT_QPA_PLATFORM = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      USE_WAYLAND_GRIM = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      XCURSOR_THEME = "BreezeX-RosePine-Linux";
    };

    services.gvfs.enable = true;
    services.dbus.enable = true;
    services.displayManager.sddm.astronaut-embedded-theme = "purple_leaves";
    services.xserver.desktopManager.runXdgAutostartIfNone = true;

    programs.dconf = {
      enable = true;
      profiles.user.databases = [
        {
          settings = {
            "org/gnome/desktop/interface" = {
              color-scheme = "prefer-dark";
              gtk-theme = "Adwaita";
              icon-theme = "Adwaita";
              cursor-theme = "BreezeX-RosePine-Linux";
            };
          };
        }
      ];
    };

    fonts.packages = with pkgs; [
      lato
    ];

    environment.systemPackages = with pkgs; [
      rose-pine-cursor
      gnome-themes-extra
      gnome-font-viewer
      gnome-secrets
      gnome-calculator
      gnome-text-editor
      hicolor-icon-theme
      decibels
      nautilus
      file-roller
      papers
      loupe
      showtime
      xwayland-satellite
      xdg-user-dirs
      xdg-user-dirs-gtk
      wev
    ];
  };
}
