{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
let
  system = pkgs.stdenv.hostPlatform.system;
  noctalia-shell = inputs.noctalia.packages.${system}.default.override {
    calendarSupport = true;
  };
in
{
  imports = [ inputs.noctalia.nixosModules.default ];

  config = lib.mkIf config.programs.niri.enable {
    services.noctalia-shell.enable = true;
    environment.systemPackages = with pkgs; [
      noctalia-shell
      playerctl
      cava
      evolution
    ];

    services.gnome.evolution-data-server.enable = true;
    services.gnome.gnome-keyring.enable = true;
    services.gvfs.enable = true;
    programs.dconf.enable = true;

    services.hypridle.enable = true;
    systemd.user.services.hypridle = {
      path = [
        config.programs.niri.package
        noctalia-shell
      ];
      serviceConfig = {
        PassEnvironment = [
          "PATH"
          "DBUS_SESSION_BUS_ADDRESS"
          "WAYLAND_DISPLAY"
          "XDG_RUNTIME_DIR"
          "NIRI_SOCKET"
        ];
      };
    };
  };
}
