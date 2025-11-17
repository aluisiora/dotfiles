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

  programs.nix-ld.enable = true;

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 10d";
  };
}
