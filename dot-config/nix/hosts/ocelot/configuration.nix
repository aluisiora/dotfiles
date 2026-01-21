{
  pkgs,
  ...
}:
let
  user = "aluisio";
in
{
  imports = [
    ./hardware-configuration.nix
    ./apple-studio-display.nix
    ./zsa-voyager.nix
    ./vpn.nix
    ../../nixosModules
    ../../modules
    ../../modules/development/linux.nix
  ];

  # System config
  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_US.UTF-8";
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    wireplumber.enable = true;
  };
  security.rtkit.enable = true;
  services.libinput.enable = true;
  services.openssh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  users.users.${user} = {
    description = "Aluisio Amaral";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "input"
      "docker"
    ];
  };
  nix.settings.trusted-users = [
    "root"
    "${user}"
  ];
  environment.systemPackages = with pkgs; [
    distrobox
    slack
    gnome-boxes
    obsidian
  ];
  programs.zsh = {
    enable = true;
    enableGlobalCompInit = false;
  };

  # Custom modules
  development.enable = true;
  desktop.enable = true;
  programs.niri.enable = true;
  services.displayManager.gdm.enable = true;
  virtualisation = {
    enable = true;
    boxesUsers = [ "${user}" ];
  };

  # Network
  networking.hostName = "ocelot";
  networking.firewall.enable = true;
  networking.networkmanager.enable = true;

  # Kernel and system config
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.efi.canTouchEfiVariables = true;
  system.stateVersion = "25.11";
}
