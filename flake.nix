{
	description = "jacob's NixOS flake configuration";
	inputs = {
		nixpkgs.url = "nixpkgs/nixos-26.05";
		home-manager = {
			url = "github:nix-community/home-manager/release-26.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
	};

	outputs = { self, nixpkgs, home-manager, ... }@inputs: {
		nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager
				{
          system.configurationRevision = self.rev or self.dirtyRev or "unknown";
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.jacob = import ./home.nix;
						backupFileExtension = "backup";
            extraSpecialArgs = { inherit inputs; };
					};
				}
			];
		};
	};
}
