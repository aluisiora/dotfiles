{ 
  pkgs,
  inputs,
  ...
}: {
  environment.variables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
  };

  environment.systemPackages = with pkgs; [
    vim
    curl
    btop
    nh
    fastfetch
  ];

  nixpkgs.config.allowUnfree = true;

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.optimise.automatic = true;
}
