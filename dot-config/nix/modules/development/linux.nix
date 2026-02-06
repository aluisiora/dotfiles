{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [ ./common.nix ];

  config = lib.mkIf config.development.enable {
    environment.variables = {
      DBX_CONTAINER_MANAGER = "docker";
    };
    virtualisation.docker.enable = true;
    virtualisation.docker.enableOnBoot = true;
    environment.systemPackages = with pkgs; [
      gcc
      ghostty
      gnumake
      gnupg
      pass
      psmisc
      python3
      yazi
    ];
    services.dbus.packages = [ pkgs.ghostty ];
    systemd.packages = [ pkgs.ghostty ];
  };
}
