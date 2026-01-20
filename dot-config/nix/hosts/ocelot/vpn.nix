{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    xl2tpd
    strongswan
    networkmanager-l2tp
    networkmanager-openvpn
    networkmanager-strongswan
  ];

  networking.networkmanager = {
    plugins = with pkgs; [
      networkmanager-l2tp
      networkmanager-openvpn
      networkmanager-strongswan
    ];
  };
  programs.openvpn3.enable = true;
  services.xl2tpd.enable = true;
  services.strongswan = {
    enable = true;
    secrets = [ "ipsec.d/ipsec.nm-l2tp.secrets" ];
  };
  systemd.tmpfiles.rules = [
    "L /etc/ipsec.secrets - - - - /etc/ipsec.d/ipsec.nm-l2tp.secrets"
  ];
}
