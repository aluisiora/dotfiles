{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
let
  system = pkgs.stdenv.hostPlatform.system;
  hamr = inputs.hamr.packages.${system}.default;
in
{
  config = lib.mkIf config.programs.niri.enable {
    environment.systemPackages = [ hamr ];
    systemd.user.services.hamr = {
      enable = true;
      description = "Hamr Launcher for Quickshell";
      documentation = [ "https://github.com/Stewart86/hamr" ];
      wantedBy = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${hamr}/bin/hamr";
        Type = "simple";
        Restart = "on-failure";
        RestartSec = 3;
      };
    };
  };
}
