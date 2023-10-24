{ lib, config, pkgs, ... }:
{
  imports = [../spicetify.nix];
  home.username = "philopater";
  home.homeDirectory = "/home/philopater";
  home.packages = [
  pkgs.pamixer
  pkgs.pciutils
  pkgs.gcc
  ];
nixpkgs.config.allowUnfree = true;
  # imports = [ ../spicetify.nix ];
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.git = {
    enable = true;
    userName = "Felopater Melika";
    userEmail = "felopatermelika@gmail.com";
    aliases = {
      pu = "push";
      co = "checkout";
      cm = "commit";
    };
  };

  gtk = {
    enable = true;
    theme.name = "adw-gtk3";
    cursorTheme.name = "Bibata-Modern-Ice";
    iconTheme.name = "GruvboxPlus";
  };
  
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
  };

  home.stateVersion = "23.05";
}
