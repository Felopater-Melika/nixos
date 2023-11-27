{ pkgs ? import <nixpkgs> {} }:

pkgs.appimageTools.wrapType2 {
  name = "clickup";
  src = pkgs.fetchurl {
    url = "https://desktop.clickup.com/linux";
    sha256 = "sha256-3CD+VA+Id/PAO3+TpKBSe+F/lBUTLTt2AHW9dG709xE=";
  };
    extraPkgs = pkgs: with pkgs; [ xorg.libxkbfile ];
}

