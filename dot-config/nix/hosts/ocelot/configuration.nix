{
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./apple-studio-display.nix
    ../../nixosModules
    ../../modules
    ../../modules/development/linux.nix
  ];

  # Custom modules
  development.enable = true;

  # System config
  networking.hostName = "ocelot";
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-l2tp
      networkmanager-openvpn
      networkmanager-strongswan
    ];
  };
  programs.openvpn3.enable = true;
  services.strongswan = {
    enable = true;
    secrets = [
      "ipsec.d/ipsec.nm-l2tp.secrets"
    ];
  };
  services.xl2tpd.enable = true;
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
  users.users.aluisio = {
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
    "aluisio"
  ];
  environment.systemPackages = with pkgs; [
    distrobox
  ];
  programs.zsh = {
    enable = true;
    enableGlobalCompInit = false;
  };
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  system.stateVersion = "25.05";
}
