{ pkgs, ... }:
{
  systemd.services.vanta-autostart = {
    description = "Start Vanta Agent inside Distrobox";
    after = [ "docker.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple"; # Changed to simple if the daemon stays in foreground, or keep oneshot
      ExecStart = "${pkgs.distrobox}/bin/distrobox enter vanta -- sudo systemctl start vanta";
      Restart = "on-failure";
      RestartSec = "10s";
    };
  };
}
