{
  description = "Cole's Nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  outputs = { self, nixpkgs, nixos-wsl, darwin, home-manager, sops-nix, ... }@inputs: {
    nixosConfigurations = {
      wsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-wsl.nixosModules.default
          home-manager.nixosModules.home-manager
          sops-nix.nixosModules.sops
          {
	    home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.cg = import ./home/cg/home.nix;
          }
          ./hosts/wsl
        ];
      };

      swift = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          sops-nix.nixosModules.sops
          {
	    home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.cg = import ./home/cg/desktop-plasma-home.nix;
          }
          ./hosts/swift
        ];
      };

      vm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          sops-nix.nixosModules.sops
          {
	    home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.cg = import ./home/cg/home.nix;
          }
          ./hosts/vm
        ];
      };
    };

    darwinConfigurations = {
      macbook = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
	modules = [
          home-manager.darwinModules.home-manager
          sops-nix.darwinModules.sops
          {
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.cg = import ./home/cg/home.nix;
          }
          ./darwin/macbook.nix
        ];
      };
    };
  };
}
