{
  pkgs,
  lib,
  config,
  ...
}:
let
  noctalia-shell = (pkgs.noctalia-shell.override { calendarSupport = true; });
in
{
  config = lib.mkIf config.programs.niri.enable {
    environment.systemPackages = with pkgs; [
      cava
      evolution
      gnome-control-center
      noctalia-shell
      playerctl
      gpu-screen-recorder
      gpu-screen-recorder-gtk
    ];

    services.power-profiles-daemon.enable = true;
    services.upower.enable = true;
    services.gvfs.enable = true;
    programs.dconf.enable = true;
    programs.gpu-screen-recorder.enable = true;

    # Enable the Evolution Data Server
    services.gnome.evolution-data-server.enable = true;
    services.gnome.gnome-online-accounts.enable = true;

    # Required for storing Google credentials
    services.gnome.gnome-keyring.enable = true;
    security.polkit.enable = true;

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
