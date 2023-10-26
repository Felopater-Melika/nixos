{ inputs, config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  users.users.philopater.shell = "${pkgs.zsh}/bin/zsh";
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = { philopater = import ./home.nix; };
  };

  nixpkgs.config.permittedInsecurePackages = [ "python-2.7.18.7" ];
  fileSystems = {
    "/" = { options = [ "compress=zstd" ]; };
    "/home" = { options = [ "compress=zstd" ]; };
    "/nix" = { options = [ "compress=zstd" "noatime" ]; };
  };

  boot.loader.systemd-boot.enable = true;
  # boot.loader.grub = {
  #  enable = true;
  #  version = 2;
  #  device = "/dev/nvme0n1p1";
  #  useOSProber = true;
  # };
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  # Set your time zone.
  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  xdg.portal.enable = true;
  # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  services.xserver.layout = "us";

  services.printing.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  hardware.opengl.enable = true;

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart =
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
    extraConfig = ''
      DefaultTimeoutStopSec = 10s
    '';
  };

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
      source-han-sans
      source-han-sans-japanese
      source-han-serif-japanese
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "JetBrains Mono Nerd Font" ];
        serif = [ "Noto Serif" "Source Han Serif" ];
        sansSerif = [ "Noto Sans" "Source Han Sans" ];
      };
    };
  };

  services.xserver.libinput.enable = true;
  virtualisation.docker.enable = true;
  programs.dconf.enable = true;
  services.supergfxd.enable = true;
  services.asusd = {
    enable = true;
    enableUserService = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  security.pam.services.swaylock = { };

  users.users.philopater = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "bluetooth"
      "networkmanager"
      "docker"
      "audio"
      "libvirtd"
      "kvm"
      "disk"
      "input"
      "media"
      "plugdev"
      "lxd"
      "adbusers"
      "users"
      "video"
    ];
    packages = with pkgs; [ ];
  };

  environment.systemPackages = with pkgs; [
      nixfmt
    rofi-wayland
    gh
    home-manager
    swww
    mako
    neofetch
    pfetch
    fontconfig
    ripgrep
    qemu
    jetbrains-mono
    polkit_gnome
    pavucontrol
    python3Full
    eza
    python.pkgs.pip
    unzip
    tldr
    swaylock
    cava
    waybar
    libnotify
    bluez
    blueman
    neovim
    (pkgs.discord.override {
  src = builtins.fetchTarball {
    url = "https://dl.discordapp.net/apps/linux/0.0.32/discord-0.0.32.tar.gz";
    sha256 = "sha256:0qzdvyyialvpiwi9mppbqvf2rvz1ps25mmygqqck0z9i2q01c1zd";
  };
  withOpenASAR = true;
  withVencord = true;
  vencord = (pkgs.vencord.overrideAttrs {
    src = fetchFromGitHub {
      owner = "Vendicated";
      repo = "Vencord";
      rev = "70943455161031d63a4481249d14833afe94f5a5";
      hash = "sha256-i/n7qPQ/dloLUYR6sj2fPJnvvL80/OQC3s6sOqhu2dQ=";
    };
  });
})
    kitty
    firefox
    wget
  ];

nixpkgs.overlays = [
   
  (self: super: {
    discord = super.discord.overrideAttrs (
      _: { src = builtins.fetchTarball {
        url = "https://discord.com/api/download?platform=linux&format=tar.gz";
        sha256 = "0qzdvyyialvpiwi9mppbqvf2rvz1ps25mmygqqck0z9i2q01c1zd"; #52 0's
      }; }
    );
  }) 
  ];
  services.openssh.enable = true;

  networking.firewall.enable = false;

  system.stateVersion = "23.05";
}

