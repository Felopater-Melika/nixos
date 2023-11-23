{ pkgs ? import <nixpkgs> {} }:

pkgs.appimageTools.wrapType2 {
  name = "clickup";
  src = pkgs.fetchurl {
    url = "https://desktop.clickup.com/linux";
    sha256 = "1vq4w5ivv6rwcrykj0dmgp258dmbpkax6xd1rna9jsgh6v2g5vm9";
  };
  extraPkgs = pkgs: with pkgs; [ ];
}

