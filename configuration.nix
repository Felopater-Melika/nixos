{ inputs, config, pkgs, stable-pkgs, master-pkgs, ... }:
let
  tokyo-night-sddm =
    pkgs.libsForQt5.callPackage ./tokyo-night-sddm/default.nix { };
in {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  users.users.philopater.shell = "${pkgs.zsh}/bin/zsh";
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = { philopater = import ./home.nix; };
  };

  nixpkgs.config.permittedInsecurePackages =
    [ "python-2.7.18.8" "electron-24.8.6" ];

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
  networking.wireless.enable = false;
  # Set your time zone.
  time.timeZone = "America/Chicago";
  services.ntp.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #    font = "Lat2-Terminus16";
  #    keyMap = "us";
  #    useXkbConfig = true; # use xkbOptions in tty.
  #  };

  services.xserver.enable = true;
  # services.geoclue2.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.theme = "tokyo-night-sddm";

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  services.xserver.xkb.layout = "us";

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

   services.xserver.videoDrivers = [ "modesetting" ];

    hardware.opengl = {
     enable = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
       amdvlk
       rocmPackages.clr.icd

  ];
   extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];

 };
  

  environment.sessionVariables = {
    # WLR_NO_HARDWARE_CURSORS = "1";
    # ELECTRON_ENABLE_STACK_DUMPING = "true";
    # ELECTRON_NO_ATTACH_CONSOLE = "true";
    # WARP_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    DOTNET_ROOT = "${pkgs.dotnet-sdk_8}";
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
  programs.nix-ld.enable = true;

  programs.nix-ld.libraries = with pkgs; [ stylua ];
  environment.systemPackages = with pkgs; [
    nixfmt-classic
    wireplumber
    tokyo-night-sddm
    meson
    gnumake
    gh
    home-manager
    swww
    mako
    neofetch
    waybar
    stylua
    pfetch
    fontconfig
    # master-pkgs.warp-terminal
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
    logiops
    libnotify
    bluez
    blueman
    brave
    geoclue2
    neovim
    kitty
    firefox
    wget
  ];

  services.openssh.enable = true;
  systemd.services.logiops = {
    description = "An unofficial userspace driver for HID++ Logitech devices";
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.logiops}/bin/logid";
    };
  };

  # Configuration for logiops
  environment.etc."logid.cfg".text = ''
       // Logiops (Linux driver) configuration for Logitech MX Master 3.
    // Includes gestures, smartshift, DPI.
    // Tested on logid v0.2.3 - GNOME 3.38.4 on Zorin OS 16 Pro
    // What's working:
    //   1. Window snapping using Gesture button (Thumb)
    //   2. Forward Back Buttons
    //   3. Top button (Ratchet-Free wheel)
    // What's not working:
    //   1. Thumb scroll (H-scroll)
    //   2. Scroll button

    // File location: /etc/logid.cfg

    devices: ({
      name: "MX Master 3S";

      smartshift: {
        on: true;
        threshold: 15;
      };

     hiresscroll: {
       hires: true;
       invert: false;
       target: false;
     };

      dpi: 1000; // max=4000

      buttons: (
        // Forward button for Copy
        {
          cid: 0x53;
          action = {
            type: "Keypress";
            keys: [ "KEY_LEFTCTRL", "KEY_C" ];
          };
        },
        // Back button for Paste
        {
          cid: 0x56;
          action = {
            type: "Keypress";
            keys: [ "KEY_LEFTCTRL", "KEY_V" ];
          };
        },
        // Gesture button (hold and move)
        {
          cid: 0xc3;
          action = {
            type: "Gestures";
            gestures: (
              {
                direction: "None";
                mode: "OnRelease";
                action = {
                  type: "Keypress";
                  keys: [ "KEY_LEFTMETA", "KEY_S" ]; // Windows + S
                }
              },
    	 {
                direction: "Up";
                mode: "OnRelease";
                action = {
                  type: "Keypress";
                  keys: [ "KEY_LEFTCTRL", "KEY_A" ]; // Ctrl+A to select all
                }
              },
              {
                direction: "Down";
                mode: "OnRelease";
                action = {
                  type: "Keypress";
                  keys: [ "KEY_LEFTMETA", "KEY_V" ]; // Windows+V
                }
              },
              {
                direction: "Right";
                mode: "OnRelease";
                action = {
                  type: "Keypress";
                  keys: [ "KEY_LEFTMETA", "KEY_X" ]; // Windows+X
                }
              },
              {
                direction: "Left";
                mode: "OnRelease";
                action = {
                  type: "Keypress";
                  keys: [ "KEY_LEFTMETA", "KEY_I" ]; // Windows+I
                }
              },
            );
          };
        },

        // Top button
        {
          cid: 0xc4;
          action = {
            type: "Gestures";
            gestures: (
              {
                direction: "None";
                mode: "OnRelease";
                action = {
                  type: "ToggleSmartShift";
                }
              },

              {
                direction: "Up";
                mode: "OnRelease";
                action = {
                  type: "ChangeDPI";
                  inc: 1000,
                }
              },

              {
                direction: "Down";
                mode: "OnRelease";
                action = {
                  type: "ChangeDPI";
                  inc: -1000,
                }
              }
            );
          };
        }
      );
    });
  '';
  networking.firewall.enable = false;

  # Enable zram swap
  zramSwap = {
    enable = true; # Enable zram swap

    # Total amount of zram memory. A percentage of total RAM is recommended.
    # For heavy workloads, considering your 16GB RAM, setting zram to use up to 50% of RAM.
    # Adjust based on your needs and experimentation.
    memoryPercent = 50;

    # Set the maximum amount of zram memory. This is a safety cap in absolute terms,
    # which is useful if you want to ensure zram never exceeds a certain size.
    # This is optional and can be adjusted or omitted based on preference.
    # memoryMax = "8G"; # Uncomment and adjust as necessary

    # Set the compression algorithm. Lz4 is fast with reasonable compression.
    # You may experiment with 'zstd' for potentially better compression at the cost of CPU.
    algorithm = "zstd";

    # Adjust the priority of the zram swap relative to other swap devices.
    # Higher numbers indicate higher priority. Default is usually sufficient.
    priority = 100;

    # This option is not directly part of NixOS's zram configuration but would be
    # relevant if configuring additional swap devices manually or using systemd services.
    # swapDevices = [ ... ];

    # For systems with a known fast storage device for swap, like an NVMe drive,
    # setting a writeback device can offload swapped out data from zram under pressure.
    # This is an advanced option and typically not necessary for most users.
    # writebackDevice = "/dev/nvme0n1"; # Example, adjust as per your system
  };

  # Placeholder for enabling a swap file via systemd service
  # This section will need to be filled in when you're ready to add a swap file
  # services.zram-generator.settings = { ... };
  # services.zram-generator.package = pkgs.zram-generator;
  # services.zram-generator.enable = true;

  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [ "/" ];
  };

  systemd.oomd.enableRootSlice = true;
  systemd.oomd.enableSystemSlice = true;
  systemd.oomd.enableUserSlices = true;

  system.stateVersion = "23.11";
}
