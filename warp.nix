{ pkgs ? import <nixpkgs> {} }:

pkgs.appimageTools.wrapType2 {
  name = "warp-terminal";
  src = pkgs.fetchurl {
    url = "https://app.warp.dev/get_warp?linux=true&package=appimage";
    sha256 = "51570bd032ded69f42341047ca12f716a74dfdde";
  };
    extraPkgs = pkgs: with pkgs; [ xorg.libxkbfile ];
}
