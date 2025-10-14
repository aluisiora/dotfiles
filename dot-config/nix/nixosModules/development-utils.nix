{
  pkgs,
  config,
  lib,
  ...
}:
{
  options = {
    developmentUtils.enable = lib.mkEnableOption "development utilities";
  };

  config = lib.mkIf config.developmentUtils.enable {
    environment.variables = {
      DBX_CONTAINER_MANAGER = "docker";
    };
    virtualisation.docker.enable = true;
    virtualisation.docker.enableOnBoot = true;
    environment.systemPackages = with pkgs; [
      psmisc
      lazydocker
      yazi
      gnumake
      gcc
    ]);
  };
}
