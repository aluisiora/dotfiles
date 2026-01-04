{
  description = "My NixOS system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nix-darwin,
      ...
    }@inputs:
    {
      nixosConfigurations.ocelot = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [ ./hosts/ocelot/configuration.nix ];
      };

      nixosConfigurations.otacon = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [ ./hosts/otacon/configuration.nix ];
      };

      darwinConfigurations.snake = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs; };
        modules = [ ./hosts/snake/configuration.nix ];
      };
    };
}
