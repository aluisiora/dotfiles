{
  lib,
  config,
  ...
}:
{
  options = {
    plymouth = {
      enable = lib.mkEnableOption "themed plymouth";
    };
  };

  config = lib.mkIf config.plymouth.enable {
    boot.consoleLogLevel = 3;
    boot.initrd.verbose = false;
    boot.kernelParams = [
      "quiet"
      "udev.log_priority=3"
      "systemd.show_status=auto"
    ];
    boot.initrd.kernelModules = [
      "amdgpu"
    ];
    boot.plymouth = {
      enable = true;
      theme = "bgrt";
    };
  };
}
