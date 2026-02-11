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
      psmisc
      python3
      yazi
      openssl
      libsecret
    ];
    services.dbus.packages = [ pkgs.ghostty ];
    systemd.packages = [ pkgs.ghostty ];
    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
      openssl
      libsecret
    ];
  };
}
