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
      gnumake
      psmisc
      python3
      yazi
      openssl
      libsecret

      # For PHP compilation
      re2c
      gd
      libpq
      libzip
      autoconf
      bison
      libxml2
      oniguruma
      sqlite
    ];
    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
      openssl
      libsecret
    ];
  };
}
