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
      QT_QPA_PLATFORMTHEME = "gtk3";
      XCURSOR_THEME = "Adwaita";
      XCURSOR_SIZE = "32";
    };

    services.gvfs.enable = true;
    services.dbus.enable = true;
    services.gnome.gnome-keyring.enable = true;
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

    fonts.packages = with pkgs; [
      lato
    ];

    environment.systemPackages = with pkgs; [
      adwaita-icon-theme
      bluetui
      decibels
      deja-dup
      file-roller
      gnome-calculator
      gnome-font-viewer
      gnome-secrets
      gnome-text-editor
      gnome-themes-extra
      hicolor-icon-theme
      kdePackages.breeze-icons
      kdePackages.qt6ct
      libsecret
      loupe
      nautilus
      nwg-look
      papers
      seahorse
      showtime
      wev
      xdg-user-dirs
      xdg-user-dirs-gtk
      xeyes
      xwayland-satellite
    ];
  };
}
