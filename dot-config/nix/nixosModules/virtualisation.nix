{
  pkgs,
  config,
  lib,
  ...
}:
{
  options = {
    virtualisation = {
      enable = lib.mkEnableOption "virtualisation software";
      boxesUsers = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "List of usernames to add to libvirtd/kvm groups automatically.";
      };
    };
  };

  config = lib.mkIf config.virtualisation.enable {
    environment.systemPackages = with pkgs; [
      gnome-boxes
      virt-manager
      spice-gtk # For USB redirection client support
    ];

    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };

    # Enable USB Redirection (Spice)
    # This typically solves "device not connected" errors when sharing USB sticks
    virtualisation.spiceUSBRedirection.enable = true;

    users.users = lib.genAttrs config.virtualisation.boxesUsers (user: {
      extraGroups = [
        "libvirtd"
        "kvm"
      ];
    });
  };
}
