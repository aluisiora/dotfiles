{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    plymouth = {
      enable = lib.mkEnableOption "themed plymouth";
      theme = lib.mkOption {
        type = lib.types.anything;
        default = "hexagon_dots";
        description = "The plymouth theme from: https://github.com/adi1090x/plymouth-themes";
      };
    };
  };

  config = lib.mkIf config.plymouth.enable {
    boot.consoleLogLevel = 3;
    boot.initrd.verbose = false;
    boot.kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
    boot.initrd.availableKernelModules = [
      "amdgpu"
    ];
    boot.plymouth = {
      enable = true;
      theme = config.plymouth.theme;
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "${config.plymouth.theme}" ];
        })
      ];
    };
  };
}
