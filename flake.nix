{
  description = "Neovim with custom configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		flake-utils.url = "github:numtide/flake-utils";
	};

	outputs = { self, nixpkgs, flake-utils, ... }: {
        overlays.default = import ./overlay.nix;
    } // flake-utils.lib.eachSystem flake-utils.lib.allSystems (system:
	let 

	pkgs = import nixpkgs {
		inherit system;
		overlays = [
			self.overlays.default
		];
	};

	in rec {
        packages.default = pkgs.neovimc;

		devShells.default = pkgs.mkShell {
			packages = (with pkgs; [
				neovimc
			]);
		};

        devShell = devShells.default;
	});
}
