{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./gnome
    ./hyprland
    ./niri
  ];

  options = {
    desktop = {
      enable = lib.mkEnableOption "desktop GUI";
      extraPackages = lib.mkOption {
        type = lib.types.listOf lib.types.package;
        default = [ ];
        description = "Extra apps to include";
      };
      flathubScript = lib.mkOption {
        type = lib.types.anything;
        default = "";
        description = "Flathub script that can adds more apps declaratively";
      };
    };
  };

  config = lib.mkIf config.desktop.enable {
    programs.firefox.enable = true;
    services.flatpak.enable = true;
    systemd.services.flatpak-repo = {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.flatpak ];
      script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        ${config.desktop.flathubScript}
      '';
    };
    services.xserver.enable = true;
    services.xserver = {
      xkb = {
        layout = "us,us";
        variant = ",intl";
        options = "";
      };
    };
    fonts.enableDefaultPackages = true;
    fonts.fontDir.enable = true;
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
      dejavu_fonts
      jetbrains-mono
      liberation_ttf
      # Windows fonts
      corefonts
      vista-fonts
    ];
    environment.systemPackages =
      with pkgs;
      [
        ytmdesktop
        ghostty
        wezterm
      ]
      ++ config.desktop.extraPackages;
  };
}
