{
  description = "NixOS configuration with Noctalia";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  };



  outputs = inputs@{ self, nixpkgs,home-manager ,... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        # ... other modules
	./modules/noctalia.nix
	./hosts/configuration.nix
	./hosts/hardware-configuration.nix
	home-manager.nixosModules.home-manager{
	home-manager.useGlobalPkgs = true;
	home-manager.useUserPackages = true;
   home-manager.extraSpecialArgs = { inherit inputs; };
	home-manager.users.anand = ./home/anand.nix;

	}
      ];
    };
  };
}
