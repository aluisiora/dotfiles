{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [ ./noctalia.nix ];

  config = lib.mkIf config.programs.niri.enable {
    environment.variables = {
      NIXOS_OZONE_WL = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      SDL_VIDEODRIVER = "wayland";
      QT_QPA_PLATFORM = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      USE_WAYLAND_GRIM = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      XCURSOR_THEME = "Adwaita";
      XCURSOR_SIZE = "32";
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
              font-name = "Lato Regular 10";
              document-font-name = "Lato Regular 10";
              cursor-theme = "Adwaita";
            };
          };
        }
      ];
    };
    qt.enable = true;
    qt.platformTheme = "qt5ct";
    qt.style = "breeze";

    fonts.packages = with pkgs; [
      lato
    ];

    environment.systemPackages = with pkgs; [
      kdePackages.breeze-icons
      kdePackages.qt6ct
      adwaita-icon-theme
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
      xeyes
      xdg-user-dirs
      xdg-user-dirs-gtk
      wev
      bluetui
    ];
  };
}
