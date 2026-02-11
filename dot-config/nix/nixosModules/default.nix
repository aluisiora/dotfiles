{
  pkgs,
  ...
}:
{
  imports = [
    ./desktop
    ./plymouth.nix
    ./sddm.nix
    ./development-utils.nix
    ./virtualisation.nix
  ];

  environment.systemPackages = with pkgs; [
    dysk
    zip
    unzip
    rar
    coreutils
    findutils
    file
  ];

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 10d";
  };
}
