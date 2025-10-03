{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
let
  quickshell-git = inputs.quickshell.packages.${pkgs.system}.default.override {
    withX11 = false;
    withI3 = false;
  };
  gabarito-font = pkgs.callPackage ./pkgs/gabarito-font.nix { };
  end4-shell = pkgs.callPackage ./pkgs/end4-shell.nix { quickshell = quickshell-git; };
  oneui4-icons = pkgs.callPackage ./pkgs/oneui4-icons.nix { };
in
{
  options = {
    programs.hyprland.ii.enable = lib.mkEnableOption "illogical-impulse shell";
  };

  config = lib.mkIf config.programs.hyprland.ii.enable {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-gtk
          kdePackages.fcitx5-qt
        ];
      };
    };

    services.geoclue2.enable = true;
    services.gnome.gnome-keyring.enable = true;

    qt.enable = lib.mkForce true;
    qt.platformTheme = lib.mkForce "qt5ct";
    qt.style = lib.mkForce "kvantum";

    fonts.packages = with pkgs; [
      nerd-fonts.ubuntu
      nerd-fonts.ubuntu-mono
      nerd-fonts.caskaydia-cove
      nerd-fonts.fantasque-sans-mono
      nerd-fonts.space-mono
      rubik
      material-symbols
      gabarito-font
    ];
    environment.systemPackages = with pkgs; [
      quickshell-git
      end4-shell
      oneui4-icons
      kdePackages.kdialog
      kdePackages.kcmutils
      kdePackages.qt5compat
      kdePackages.qtbase
      kdePackages.qtdeclarative
      kdePackages.qtimageformats
      kdePackages.qtmultimedia
      kdePackages.qtpositioning
      kdePackages.qtquicktimeline
      kdePackages.qtsensors
      kdePackages.qtsvg
      kdePackages.qttools
      kdePackages.qttranslations
      kdePackages.qtvirtualkeyboard
      kdePackages.qtwayland
      kdePackages.syntax-highlighting
      kdePackages.plasma-workspace
      kdePackages.plasma-systemmonitor
      kdePackages.bluedevil
      kdePackages.bluez-qt
      kdePackages.plasma-nm
      kdePackages.kwallet
      kdePackages.polkit-kde-agent-1

      # Audio
      cava
      lxqt.pavucontrol-qt
      wireplumber
      libdbusmenu-gtk3
      playerctl
      easyeffects

      # Bluetooth
      bluetui

      # Backlight
      brightnessctl
      ddcutil

      # Screenshot
      hyprshot
      slurp
      swappy
      tesseract
      wf-recorder

      # Toolkit
      # wtype
      # ydotool
      hyprpicker

      # Widgets
      # glib
      # swww
      translate-shell
      wlogout

      # Misc
      bc
      cliphist
      curl
      libqalculate
      jq
      fuzzel
      matugen
      wl-clipboard
      imagemagick
      python313Packages.kde-material-you-colors
      (python3.withPackages (
        python-pkgs: with python-pkgs; [
          build
          pillow
          setuptools-scm
          wheel
          pywayland
          psutil
          materialyoucolor
          libsass
          material-color-utilities
          setproctitle
        ]
      ))
    ];
  };
}
