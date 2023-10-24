{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-contrib.url = "github:hyprwm/contrib";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nur.url = "github:nix-community/NUR";

    # spicetify-nix = {
    #       url = "github:Gerg-L/spicetify-nix";
    #  inputs.nixpkgs.follows = "nixpkgs"; 
    #   };
      spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs"; 
      };
    };

  outputs = { self, nixpkgs, home-manager, chaotic, nur, hyprland
    , hyprland-contrib, spicetify-nix, ... }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;

        config = { allowUnfree = true; };
      };
    in {
      nixosConfigurations = {
        myNixos = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ ./nixos/configuration.nix ];
        };
      };
    };
}
