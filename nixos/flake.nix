{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      stable = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations.nixos-pc = lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit stable;
        };
        modules = [ ./pc/configuration.nix ];
      };

      nixosConfigurations.nixos-work-laptop = lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit stable;
        };
        modules = [ ./work-laptop/configuration.nix ];
      };
    };
}
