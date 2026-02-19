{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./gnome
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
    fonts = {
      enableDefaultPackages = true;
      fontDir.enable = true;
      packages = with pkgs; [
        _0xproto
        monaspace
        maple-mono.NF
        noto-fonts
        noto-fonts-cjk-sans
        dejavu_fonts
        font-awesome
        jetbrains-mono
        googlesans-code
        inter
        roboto
        ubuntu-sans
        # Windows fonts and alternatives
        corefonts
        vista-fonts
        liberation_ttf
        # Emoji
        noto-fonts-color-emoji
      ];
      fontconfig = {
        defaultFonts = {
          emoji = [ "Noto Color Emoji" ];
          sansSerif = [ "Lato" "Dejavu Sans" ];
          serif = [ "DejaVu Serif" ];
          monospace = [ "0xProto" "Monaspace Neon" ];
        };
      };
    };
    environment.systemPackages = with pkgs; [
      ghostty
    ];
    services.dbus.packages = [ pkgs.ghostty ];
    systemd.packages = [ pkgs.ghostty ];
  };
}
