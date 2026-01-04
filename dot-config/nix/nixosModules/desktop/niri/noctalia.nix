{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  imports = [ inputs.noctalia.nixosModules.default ];

  config = lib.mkIf config.programs.niri.enable {
    services.noctalia-shell.enable = true;
    services.gnome.evolution-data-server.enable = true;
    environment.systemPackages = [
      (inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
        calendarSupport = true;
      })
    ];
  };
}
