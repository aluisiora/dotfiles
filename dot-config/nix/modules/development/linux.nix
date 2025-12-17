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
      psmisc
      yazi
      gnumake
      gcc
      python3
    ];
  };
}
