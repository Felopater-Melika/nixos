{
  description = "Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";

    nixpkgs-master.url = "github:NixOS/nixpkgs/master";

    nix-super.url = "github:privatevoid-net/nix-super";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    hyprland-plugins = {
      inputs.hyprland.follows = "hyprland";
      url = "github:hyprwm/hyprland-plugins";
    };  

    hyprland-contrib.url = "github:hyprwm/contrib";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    nur.url = "github:nix-community/NUR";

    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hy3 = {
      url = "github:outfoxxed/hy3";
      inputs.hyprland.follows = "hyprland";
    };

    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, home-manager, chaotic, nur, hyprland
    , hyprland-contrib, hyprland-plugins, spicetify-nix, nixpkgs-stable, hy3, nix-super, nixpkgs-master, ... }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };

      stable-pkgs = import nixpkgs-stable {
        inherit system;
        config = { allowUnfree = true; };
      };

      master-pkgs = import nixpkgs-master {
inherit system;
        config = { allowUnfree = true; };

      };

    in {
      nixosConfigurations = {
        myNixos = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit stable-pkgs master-pkgs hyprland-plugins inputs; };
          modules = [ ./nixos/configuration.nix ];
        };
      };
    };
}
