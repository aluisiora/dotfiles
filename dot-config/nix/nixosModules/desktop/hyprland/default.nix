{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./bars/illogical-impulse
    ./bars/caelestia.nix
    ./bars/hyprpanel.nix
    ./bars/waybar.nix
  ];

  config = lib.mkIf config.programs.hyprland.enable {
    environment.variables = {
      NIXOS_OZONE_WL = "1";
      SDL_VIDEODRIVER = "wayland";
      QT_QPA_PLATFORM = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      USE_WAYLAND_GRIM = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    };

    programs.hyprland = {
      xwayland.enable = true;
    };
    programs.hyprlock.enable = true;
    programs.dconf = {
      enable = true;
      profiles.user.databases = [
        {
          settings = {
            "org/gnome/desktop/interface" = {
              color-scheme = "prefer-dark";
              gtk-theme = "Adwaita";
              icon-theme = "Adwaita";
              font-name = "Lato Regular 11";
              document-font-name = "Lato Regular 11";
              monospace-font-name = "Fira Mono Medium 13";
            };
          };
        }
      ];
    };

    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Liberation Serif" ];
        sansSerif = [ "Lato Regular" ];
        monospace = [ "Fira Code Mono" ];
      };
    };
    fonts.packages = with pkgs; [
      lato
      fira-code
      fira-code-symbols
      liberation_ttf
    ];

    qt = {
      enable = true;
      platformTheme = "qt5ct";
    };

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
    };
    xdg.mime = {
      enable = true;
      defaultApplications = {
        "default-web-browser" = [ "google-chrome.desktop" ];
        "text/html" = [ "google-chrome.desktop" ];
        "text/xml" = [ "google-chrome.desktop" ];
        "application/pdf" = [ "google-chrome.desktop" ];
        "x-scheme-handler/http" = [ "google-chrome.desktop" ];
        "x-scheme-handler/https" = [ "google-chrome.desktop" ];
        "x-scheme-handler/xhtml+xml" = [ "google-chrome.desktop" ];
        "x-scheme-handler/about" = [ "google-chrome.desktop" ];
        "x-scheme-handler/unknown" = [ "google-chrome.desktop" ];
      };
    };

    services.hypridle.enable = true;
    services.gvfs.enable = true;
    services.dbus.enable = true;
    services.gnome.gnome-keyring.enable = true;
    services.displayManager.sddm.astronaut-embedded-theme = "japanese_aesthetic";
    services.xserver.desktopManager.runXdgAutostartIfNone = true;

    environment.systemPackages = with pkgs; [
      rose-pine-cursor
      gnome-themes-extra
      libsForQt5.qt5ct
      kdePackages.qt6ct
      kdePackages.breeze
      kdePackages.breeze-icons
      adwaita-qt
      hicolor-icon-theme
      xsettingsd

      # Apps
      nautilus
      flameshot
      file-roller
      gnome-font-viewer
    ];
  };
}
