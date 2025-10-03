{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./desktop
    ./development-utils.nix
    ./plymouth.nix
    ./sddm.nix
  ];

  environment.variables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    curl
    psmisc
    btop
    nh
    fastfetch
    dysk
  ];

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.optimise.automatic = true;
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 10d";
}
