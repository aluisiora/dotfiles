{ inputs, ... }:
{
  imports = [
    ../../modules
    ../../modules/development/darwin.nix
  ];

  development.enable = true;

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  nix.gc = {
    automatic = true;
    interval = {
      Hour = 0;
      Minute = 0;
    };
    options = "--delete-older-than 14d";
  };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
