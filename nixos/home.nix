{hyprland-plugins, lib, config, pkgs, inputs, ... }: {

  imports = [ inputs.hyprland.homeManagerModules.default  inputs.nix-colors.homeManagerModules.default ../spicetify.nix ];

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;
  nixpkgs.config.permittedInsecurePackages = [ "electron-24.8.6" ];
  home.username = "philopater";
  home.homeDirectory = "/home/philopater";
  # nixpkgs.overlays = [
  #   (self: super: {
  #     warp-terminal = import ../warp.nix { inherit pkgs; };
  #   })
  # ];

  home.packages = [
    pkgs.dotnet-sdk_8
    pkgs.boxes
    pkgs.todoist-electron
    pkgs.lavat
    inputs.nixpkgs-master.warp-terminal
    pkgs.pokeget-rs
    pkgs.rofi-wayland
    pkgs.biome
    pkgs.gimp
    pkgs.audacity
    pkgs.inkscape
    pkgs.alejandra
    pkgs.gitflow
    inputs.nix-super.packages.x86_64-linux.default
    pkgs.gammastep
    pkgs.electron
    pkgs.appimage-run
    pkgs.hyprpicker
    pkgs.hollywood
    pkgs.lazydocker
    pkgs.neovide
    pkgs.wayout
    pkgs.kubectl
    pkgs.devbox
    pkgs.jira-cli-go
    pkgs.taskwarrior
    pkgs.swayidle
    pkgs.kubernetes
    pkgs.taskwarrior-tui
    pkgs.btop
    pkgs.k9s
    pkgs.bun
    pkgs.copyq
    pkgs.vim
    pkgs.deno
    pkgs.wayout
    pkgs.dwt1-shell-color-scripts
    pkgs.bat
    pkgs.teams-for-linux
    pkgs.zoom-us
    pkgs.jetbrains-toolbox
    pkgs.fcitx5
    pkgs.xfce.thunar
    (pkgs.callPackage ../inshellisense.nix {})
    pkgs.catppuccin-kvantum
    pkgs.light
    pkgs.brightnessctl
    pkgs.libnotify
    pkgs.grim
    pkgs.webcord
    pkgs.pamixer
    pkgs.tree
    pkgs.pciutils
    pkgs.lf
    pkgs.swappy
    pkgs.gcc
    pkgs.zoxide
    pkgs.jq
    pkgs.grimblast
    pkgs.pipes
    pkgs.pipes-rs
    pkgs.cbonsai
    pkgs.asciiquarium
    pkgs.cowsay
    pkgs.figlet pkgs.nms
    pkgs.cmatrix
    pkgs.tty-clock
    pkgs.lolcat
    pkgs.jq
    pkgs.nodePackages_latest.pnpm
    pkgs.fd
    pkgs.du-dust
    pkgs.skim
    pkgs.zellij
    pkgs.nodejs_21
    pkgs.cargo
    pkgs.pokemonsay
    pkgs.pokemon-colorscripts-mac
    pkgs.sl
    pkgs.oh-my-zsh
    pkgs.libsForQt5.qtstyleplugin-kvantum
    pkgs.qt6Packages.qtstyleplugin-kvantum
    pkgs.libsForQt5.qt5ct
    pkgs.lxqt.lxqt-panel
    pkgs.ponysay
    pkgs.nyancat
    pkgs.lxqt.lxqt-themes
    pkgs.lxqt.lxqt-config
    pkgs.gitkraken
    pkgs.wl-clipboard
    pkgs.wf-recorder
    pkgs.playerctl
    pkgs.grim
    pkgs.slurp
    pkgs.mpd
    pkgs.mpv
    pkgs.zathura
    pkgs.ranger
    pkgs.ncmpcpp
    pkgs.socat
    pkgs.wlogout
    pkgs.httpie
    pkgs.lxqt.lxqt-qtplugin
    pkgs.cliphist
    pkgs.lazygit
    pkgs.tmux
    pkgs.catppuccin-papirus-folders
    pkgs.nitch
    pkgs.pgcli
    pkgs.commitizen
    pkgs.signal-desktop
    pkgs.xdragon
    pkgs.element-desktop
    pkgs.tgpt
    pkgs.newsboat
    pkgs.neomutt
    pkgs.nitch
    pkgs.screenfetch
    pkgs.toilet
    pkgs.fortune
  (pkgs.python3Packages.buildPythonPackage rec {
      pname = "pyprland";
      version = "1.4.1";
      src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "sha256-JRxUn4uibkl9tyOe68YuHuJKwtJS//Pmi16el5gL9n8=";
      };
      format = "pyproject";
      propagatedBuildInputs = with pkgs; [
        python3Packages.setuptools
        python3Packages.poetry-core
        poetry
      ];
      doCheck = false;
    })
  ];
  home.file.".config/hypr/pyprland.json".text = ''
    {
      "pyprland": {
        "plugins": ["scratchpads", "magnify"]
      },
      "scratchpads": {
        "term": {
          "command": "kitty --class scratchpad",
          "animation": "fromTop",
          "margin": 50
        }
      }
    }
  '';
  nixpkgs.config.allowUnfree = true;
  home.sessionVariables = {
    EDITOR = "nvim";
    "QT_STYLE_OVERRIDE" = "kvantum";
    SHELL = "${pkgs.zsh}/bin/zsh";
    XCURSOR_THEME = "Catppuccin-Mocha-Dark-Cursors";
  };

home.pointerCursor = {
  gtk.enable = true;
  package = pkgs.catppuccin-cursors.mochaDark;
  name = "Catppuccin-Mocha-Dark-Cursors";
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
  qt = {
    enable = true;
    platformTheme = "qtct";
    style.name = "kvantum";
  };
  programs.lf = {
    enable = true;
    commands = {
      dragon-out = ''%${pkgs.xdragon}/bin/xdragon -a -x "$fx"'';
      editor-open = "$$EDITOR $f";
      mkdir = ''
        ''${{
          printf "Directory Name: "
          read DIR
          mkdir $DIR
        }}
      '';
    };

    keybindings = {

      "\\\"" = "";
      o = "";
      c = "mkdir";
      "." = "set hidden!";
      "`" = "mark-load";
      "\\'" = "mark-load";
      "<enter>" = "open";

      do = "dragon-out";

      "g~" = "cd";
      gh = "cd";
      "g/" = "/";

      ee = "editor-open";
      V = ''$''${pkgs.bat}/bin/bat --paging=always --theme=gruvbox "$f"'';

      # ...
    };

    settings = {
      preview = true;
      hidden = true;
      drawbox = true;
      icons = true;
      ignorecase = true;
    };

    extraConfig = let
      previewer = pkgs.writeShellScriptBin "pv.sh" ''
        file=$1
        w=$2
        h=$3
        x=$4
        y=$5

        if [[ "$( ${pkgs.file}/bin/file -Lb --mime-type "$file")" =~ ^image ]]; then
            ${pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
            exit 1
        fi

        ${pkgs.pistol}/bin/pistol "$file"
      '';
      cleaner = pkgs.writeShellScriptBin "clean.sh" ''
        ${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
      '';
    in ''
      set cleaner ${cleaner}/bin/clean.sh
      set previewer ${previewer}/bin/pv.sh
    '';
  };

  gtk = {
    enable = true;

    gtk2 = {
      extraConfig = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk3.extraConfig = { gtk-application-prefer-dark-theme = true; };

    gtk4.extraConfig = { gtk-application-prefer-dark-theme = true; };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders;
    };

    cursorTheme = {
      name = "Catppuccin-Mocha-Dark-Cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
      size = 24;
    };

    theme = {
      name = "Catppuccin-Mocha-Standard-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" ];
        size = "standard";
        variant = "mocha";
      };
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;

    changeDirWidgetOptions = [ "--preview 'tree -C {} | head -200'" ];

    defaultCommand = "rg --files";
    defaultOptions = [ "--height 90%" "--border" ];

    fileWidgetCommand = "rg --files";
    fileWidgetOptions = [
      "--preview 'bat -n --color=always {}'"
      "--bind 'ctrl-/:change-preview-window(down|hidden|)'"
    ];

    tmux.enableShellIntegration = true;
    colors = {
      "bg+" = "#313244"; # Surface0
      "fg+" = "#cdd6f4"; # Text
      "hl+" = "#f38ba8"; # Red
      bg = "#313244"; # Surface0
      fg = "#cdd6f4"; # Text
      header = "#f38ba8"; # Red
      hl = "#f38ba8"; # Red
      info = "#cba6f7"; # Mauve
      marker = "#cdd6f4"; # Text
      pointer = "#cdd6f4"; # Text
      prompt = "#cba6f7"; # Mauve
      spinner = "#cdd6f4"; # Text
    };

  };

  programs = {
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = lib.mkDefault {
        format = lib.concatStrings [
          "$os"
          "$username"
          "$hostname"
          "$directory"
          "$git_branch"
          "$git_state"
          "$git_status"
          "$docker_context"
          "$nodejs"
          "$nix_shell"
          "$fill"
          "$python"
          "$golang"
          "$status"
          "$line_break"
          "$character"
        ];

        fill.symbol = " ";
        hostname.ssh_symbol = "";
        python.format = "([ $virtualenv]($style)) ";
        rust.symbol = " ";
        status.disabled = false;
        username.format = "[$user]($style)@";

        character = {
          success_symbol = "[❯](purple)";
          error_symbol = "[❯](red)";
          vicmd_symbol = "[❯](green)";
        };

        directory = {
          read_only = " ";
          home_symbol = " ~";
          style = "blue";
          truncate_to_repo = false;
          truncation_length = 5;
          truncation_symbol = ".../";
        };

        docker_context = {
          disabled = false;
        format = " [🐋 $context](blue bold)";
        detect_files = [
          "docker-compose.web-app.yml"
          "Dockerfile_web-app"
          "docker-compose.yml" 
          "docker-compose.yaml" 
          "Dockerfile"
        ];
        };

        git_branch = {
          symbol = " ";
          format = "[ $branch]($style)";
          style = "green";
        };

        git_status = {
          format =
            "[[( $conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
          style = "cyan";
          conflicted = "​=$count ";
          untracked = "​?$count ";
          modified = "​!$count ";
          staged = "​+$count ";
          renamed = "»$count ​";
          deleted = "​✘$count ";
          stashed = "≡";
        };

        git_state = {
          format = "([$state( $progress_current/$progress_total)]($style)) ";
          style = "bright-black";
        };

        golang = {
          symbol = " ";
          format = "[$symbol$version](cyan bold) ";
        };

        kubernetes = {
          disabled = false;
          format = "[$symbol$context](cyan bold) ";
        };

        nix_shell = {
          disabled = false;
          symbol = " ";
          format = "[ $symbol($name)]($style)";
        };

        nodejs = {
          disabled = false;
          symbol = "";
          format = "[$symbol $version](bold green)";
        };
      };
    };
  };
  xdg.configFile."Kvantum/kvantum.kvconfig".source =
    (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
      General.theme = "Catppuccin-Mocha-Blue";
    };
  programs = {
    zsh = {
      oh-my-zsh = {
        enable = true;
        custom = "/home/philopater/.config/zsh-custom";
        plugins = [
        "forgit"
        "appup"
        "kctl"
        "zsh-dotnet-completion"
        "docker"
        "npm"
        "vi-mode"
        "nix-shell"
        "F-Sy-H"
        "fzf-tab"
        ];
      };
      enable = true;
      dotDir = ".config/zsh";

      enableCompletion = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;

      history = {
        save = 10000;
        size = 10000;
        path = "$HOME/.cache/zsh_history";
      };

      initExtra = ''
          pokeget random --hide-name -s
          bindkey '^[[1;5C' forward-word # Ctrl+RightArrow
          bindkey '^[[1;5D' backward-word # Ctrl+LeftArrow

          zstyle ':completion:*' completer _complete _match _approximate
          zstyle ':completion:*:match:*' original only
          zstyle ':completion:*:approximate:*' max-errors 1 numeric
          zstyle ':completion:*' menu select
          zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"

          # HACK! Simple shell function to patch ruff bins downloaded by tox from PyPI to use
          # the ruff included in NixOS - needs to be run each time the tox enviroment is
          # recreated
          patch_tox_ruff() {
            for x in $(find .tox -name ruff -type f -print); do
              rm $x;
              ln -sf $(which ruff) $x;
            done
          }

          setopt AUTO_CD
          eval "$(zoxide init zsh)"
          export EDITOR=nvim
      '';

      shellAliases = {
        ls = "eza -l --git --group-directories-first  --color=always --icons=always";
        ll = "eza -lFa --group-directories-first --git --color=always --icons=always";
        tree = "eza --tree  --icons=always --git --color=always";

        pni = "pnpm install";
        pnd = "pnpm dev";
        pnx = "pnpm dlx";
        pn = "pnpm";
        nx = "pnpm dlx nx";

        dev = "nix develop -c zsh";
        swi = "sudo nixos-rebuild switch --flake .#myNixos";
        upd = "sudo nix flake update";
        del = "sudo nix-env --delete-generations old --profile /nix/var/nix/profiles/system";

        tt = "taskwarrior-tui";

        logi = "sudo systemctl restart logiops";

        ip = "ip --color";
        ipb = "ip --color --brief";

        lazy = "lazygit --use-config-file='/home/philopater/.config/lazygit/config.yml'";

        gac = "git add -A  && git commit -a";
        gad = "git add .";
        gp = "git push";
        gst = "git status -sb";

        tf = "terraform";
        tfi = "terraform init";
        tfp = "terraform plan";
        tfa = "terraform apply -auto-approve";
        tfd = "terraform destroy -auto-approve";
        tfo = "terraform output -json";

        wgu = "sudo wg-quick up";
        wgd = "sudo wg-quick down";

        ts = "tailscale";
        tssh = "tailscale ssh";
        tst = "tailscale status";
        tsu = "tailscale up --ssh --operator=$USER";
        tsd = "tailscale down";

        js = "juju status";
        jsw = "juju status --watch 1s --color";
        jsrw = "juju status --watch 1s --color --relations";
        jdl = "juju debug-log";

        rlu = "sudo nix flake update $HOME/nixos-config";
        rlb = "rln;rlh";

        open = "xdg-open";
        k = "kubectl";

        sys = "z sys";

        conf = "z .config";

        opget = ''
          op item get "$(op item list --format=json | jq -r '.[].title' | fzf)"'';

        speedtest =
          "curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -";

        cleanup-nix = "sudo nix-collect-garbage -d";
        reload-nix =
          "sudo nixos-rebuild switch --flake /home/iggut/nixos-config";
        reload-home = "home-manager switch --flake /home/iggut/nixos-config";
      };
    };
  };
        wayland.windowManager.hyprland={
          enable = true;
	xwayland.enable = true;
          plugins = [ 
          # (pkgs.callPackage ./hyprbars.nix { inherit hyprland-plugins; } )
          # inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
          inputs.hy3.packages.${pkgs.system}.default
          # inputs.hyprland-plugins.packages.${pkgs.system}.csgo-vulkan-fix
            ];
          extraConfig = ''
$rosewaterAlpha = f5e0dc
$flamingoAlpha  = f2cdcd
$pinkAlpha      = f5c2e7
$mauveAlpha     = cba6f7
$redAlpha       = f38ba8
$maroonAlpha    = eba0ac
$peachAlpha     = fab387
$yellowAlpha    = f9e2af
$greenAlpha     = a6e3a1
$tealAlpha      = 94e2d5
$skyAlpha       = 89dceb
$sapphireAlpha  = 74c7ec
$blueAlpha      = 89b4fa
$lavenderAlpha  = b4befe

$textAlpha      = cdd6f4
$subtext1Alpha  = bac2de
$subtext0Alpha  = a6adc8

$overlay2Alpha  = 9399b2
$overlay1Alpha  = 7f849c
$overlay0Alpha  = 6c7086

$surface2Alpha  = 585b70
$surface1Alpha  = 45475a
$surface0Alpha  = 313244

$baseAlpha      = 1e1e2e
$mantleAlpha    = 181825
$crustAlpha     = 11111b

$rosewater = 0xfff5e0dc
$flamingo  = 0xfff2cdcd
$pink      = 0xfff5c2e7
$mauve     = 0xffcba6f7
$red       = 0xfff38ba8
$maroon    = 0xffeba0ac
$peach     = 0xfffab387
$yellow    = 0xfff9e2af
$green     = 0xffa6e3a1
$teal      = 0xff94e2d5
$sky       = 0xff89dceb
$sapphire  = 0xff74c7ec
$blue      = 0xff89b4fa
$lavender  = 0xffb4befe

$text      = 0xffcdd6f4
$subtext1  = 0xffbac2de
$subtext0  = 0xffa6adc8
 
$overlay2  = 0xff9399b2
$overlay1  = 0xff7f849c
$overlay0  = 0xff6c7086

$surface2  = 0xff585b70
$surface1  = 0xff45475a
$surface0  = 0xff313244

$base      = 0xff1e1e2e
$mantle    = 0xff181825
$crust     = 0xff11111b

$mainMod = SUPER

exec-once = pypr
#-- Output ----------------------------------------------------
monitor=HDMI-A-1,3440x1440@99.991997,1280x0,1
monitor=eDP-1,2560x1600@120,0x0,2
#-copeFuzzyCommandSearch) Input ----------------------------------------------------
# Configure mouse and touchpad here.
input {
    kb_layout=
    kb_variant=
    kb_model=
    kb_options=
    kb_rules=
    follow_mouse=1    
    natural_scroll=0
	force_no_accel=0
}

gestures {
    workspace_swipe=1
    workspace_swipe_fingers=3
    workspace_swipe_distance=200
    workspace_swipe_min_speed_to_force=100
  }

#-- General ----------------------------------------------------
# General settings like MOD key, Gaps, Colors, etc.
general {
    sensitivity=1.0
	 apply_sens_to_raw=0
	
    gaps_in=5
    gaps_out=10

    border_size=5
    no_border_on_floating=0
    col.active_border=$blue      
    col.inactive_border=0xFF343A40

    layout = hy3
    # damage_tracking=2 # leave it on full unless you hate your GPU and want to make it suffer
}
 # xwayland {
 # force_zero_scaling = true
 # }
#-- Decoration ----------------------------------------------------
# Decoration settings like Rounded Corners, Opacity, Blur, etc.
decoration {
    rounding=8
#    multisample_edges=1

    active_opacity=1.0
    inactive_opacity=1.0
    fullscreen_opacity=1.0

 blur {
       enabled=true
      size=1
      passes=4
      ignore_opacity=true
      new_optimizations=true
    }


    # Your blur "amount" is blur_size * blur_passes, but high blur_size (over around 5-ish) will produce artifacts.
    # if you want heavy blur, you need to up the blur_passes.
    # the more passes, the more you can up the blur_size without noticing artifacts.
}

#-- Animations ----------------------------------------------------
animations {
    enabled=1
    animation=windows,1,5,default
    animation=border,1,10,default
    animation=fade,1,8,default
    animation=workspaces,1,3,default
}

#-- Dwindle ----------------------------------------------------
# dwindle {
#    pseudotile=0 			# enable pseudotiling on dwindle
# }

#-- Misc --------------------------------------------------------
misc {
  mouse_move_enables_dpms=1
  disable_hyprland_logo = true
  vfr =true 
}

# -- workspace --
workspace=1,monitor:HDMI-A-1
workspace=2,monitor:HDMI-A-1
workspace=3,monitor:HDMI-A-1
workspace=4,monitor:HDMI-A-1
workspace=5,monitor:HDMI-A-1
workspace=6,monitor:eDP-1
workspace=7,monitor:eDP-1
workspace=8,monitor:eDP-1
workspace=9,monitor:eDP-1
workspace=10,monitor:eDP-1

# -- Float applications --
windowrule=float,yad|nm-connection-editor|pavucontrolk|xfce-polkit|kvantummanager|qt5ct|feh|Viewnior|Gpicview|Gimp|MPlayer|VirtualBox Manager|qemu|Qemu-system-x86_64|mpv

# -- Center for float applications --
windowrule=center,yad|nm-connection-editor|pavucontrolk|xfce-polkit|kvantummanager|qt5ct|feh|Viewnior|Gpicview|Gimp|MPlayer|VirtualBox Manager|qemu|Qemu-system-x86_64|mpv
 $scratchpadsize = size 80% 85%

       $scratchpad = class:^(scratchpad)$
       windowrulev2 = float,$scratchpad
       windowrulev2 = $scratchpadsize,$scratchpad
       windowrulev2 = workspace special silent,$scratchpad
       windowrulev2 = center,$scratchpad

# -- Kitty --
windowrule=opacity 1,kitty
windowrule=float,kitty_float
windowrule=size 70% 70%,kitty_float
windowrule=center,kitty_float

# -- Neovide --
windowrule=opacity 0.85,neovide
windowrule=float,neovide
windowrule=size 70% 70%,neovide
windowrule=center,neovide

# -- Spotify --
windowrule=opacity 0.85,Spotify

# -- Mpv --
windowrule=size 70% 70%,mpv

# -- Toolbox --
windowrule=opacity 1,jetbrains-toolbox
# plugin = ${inputs.hy3.packages.x86_64-linux.hy3}/lib/libhy3.so
plugin {
    hy3 {
        tabs {
            height = 5
	          padding = 8
	          render_text = false
        }

        autotile {
            enable = true
            trigger_width = 800
            trigger_height = 500
        }

        tabs {
           col.active = $blue
           col.inactive = 0xFF343A40
        }
    }
    # hyprbars {
    #     # example config
    #     bar_height = 20
    #     bar_color = $blue
    #     col.text = $text
    #
    #     # example buttons (R -> L)
    #     # hyprbars-button = color, size, on-click
    #     hyprbars-button = rgb(ff4040), 10, 󰖭, hyprctl dispatch killactive
    #     hyprbars-button = rgb(eeee11), 10, , hyprctl dispatch fullscreen 1
    # }
}
    # plugin {
    #      hyprbars {
    #        bar_height = 0
    #        bar_color = 0xee
    #        col.text = 0xff
    #        bar_text_font = 
    #        bar_text_size = 12
    #
    #        buttons {
    #          button_size = 0
    #          col.maximize = 0xff
    #          col.close = 0xff
    #          }
    #      }
    #    }
    #
    #
#-- Keybindings ----------------------------------------------------
# Variables
$term = ~/.config/hypr/scripts/terminal
$launcher= ~/.config/hypr/rofi/bin/launcher
$powermenu= ~/.config/hypr/rofi/bin/powermenu
$volume = ~/.config/hypr/scripts/volume
$backlight = ~/.config/hypr/scripts/brightness
$screenshot = ~/.config/hypr/rofi/bin/screenshot
$lockscreen = ~/.config/hypr/scripts/lockscreen
$wlogout = ~/.config/hypr/scripts/wlogout
$colorpicker = ~/.config/hypr/scripts/colorpicker
$files = thunar
$editor = kitty nvim
$clipboard = cliphist list | rofi -dmenu -theme ~/.config/hypr/rofi/themes/mocha.rasi | cliphist decode | wl-copy
$ide = jetbrains-toolbox
$browser = firefox

# -- Mouse --
bindm=SUPER,mouse:272,movewindow 
bindm=SUPER,mouse:273,resizewindow

# -- Terminal --
bind=SUPERSHIFT,RETURN,exec,$term -f
bind=SUPER,RETURN,exec,$term

# -- Apps --
bind=SUPERSHIFT,F,exec,$files
bind=SUPER,R,exec,$lockscreen
bind=SUPER,E,exec,$editor
bind=SUPER,B,exec,$browser
bind=SUPER,I,exec,$ide
bind=SUPER,C,exec,discord --enable-features=UseOzonePlatform --ozone-platform=wayland
bind=SUPER,M,exec,spotify --enable-features=UseOzonePlatform --ozone-platform=wayland
bind=SUPER,O,exec,signal-desktop 
bind=SUPER,T,exec,todoist-electron

# -- Rofi --
bind=SUPER,D,exec,$launcher
bind=SUPER,X,exec,$powermenu
bind=SUPER,S,exec,$screenshot
bind=SUPER,V,exec,$clipboard

# -- Function keys --
bind=,XF86MonBrightnessUp,exec,$backlight --inc
bind=,XF86MonBrightnessDown,exec,$backlight --dec
bind=,XF86AudioRaiseVolume,exec,$volume --inc
bind=,XF86AudioLowerVolume,exec,$volume --dec
bind=,XF86AudioMute,exec,$volume --toggle
bind=,XF86AudioMicMute,exec,$volume --toggle-mic
bind=,XF86AudioNext,exec,mpc next
bind=,XF86AudioPrev,exec,mpc prev
bind=,XF86AudioPlay,exec,mpc toggle
bind=,XF86AudioStop,exec,mpc stop

# -- Hyprland --
bind=SUPER,Q,hy3:killactive,
bind=CTRLALT,Delete,exit,
bind=SUPER,F,fullscreen,
bind=SUPER,Space,togglefloating,
bind=SUPER,P,pseudo,

# Focus
bind=SUPER,H,hy3:movefocus,l
bind=SUPER,L,hy3:movefocus,r
bind=SUPER,J,hy3:movefocus,u
bind=SUPER,K,hy3:movefocus,d

# Move
bind=SUPERSHIFT,H,hy3:movewindow,l
bind=SUPERSHIFT,L,hy3:movewindow,r
bind=SUPERSHIFT,J,hy3:movewindow,u
bind=SUPERSHIFT,K,hy3:movewindow,d

# # -- Hyprland --
# bind=SUPER,Q,killactive,
# bind=CTRLALT,Delete,exit,
# bind=SUPER,F,fullscreen,
# bind=SUPER,Space,togglefloating,
# bind=SUPER,P,pseudo,
#
# # Focus
# bind=SUPER,H,movefocus,l
# bind=SUPER,L,movefocus,r
# bind=SUPER,J,movefocus,u
# bind=SUPER,K,movefocus,d
#
# # Move
# bind=SUPERSHIFT,H,movewindow,l
# bind=SUPERSHIFT,L,movewindow,r
# bind=SUPERSHIFT,J,movewindow,u
# bind=SUPERSHIFT,K,movewindow,d

# Resize
bind=SUPERCTRL,left,resizeactive,-20 0
bind=SUPERCTRL,right,resizeactive,20 0
bind=SUPERCTRL,up,resizeactive,0 -20
bind=SUPERCTRL,down,resizeactive,0 20

# Switch workspaces with mainMod + [0-9]
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

# Move active window to a workspace with mainMod + SHIFT + [0-9]
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

# Send workspace to monitor
bind=SUPERALT,0,movecurrentworkspacetomonitor, 0
bind=SUPERALT,1,movecurrentworkspacetomonitor, 1

# ROG G15 Strix (2021) Specific binds
bind = ,156, exec, rog-control-center # ASUS Armory crate key
bind = ,211, exec, asusctl profile -n; pkill -SIGRTMIN+8 waybar # Fan Profile key switch between power profiles
bind = ,121, exec, pamixer -t # Speaker Mute FN+F1
bind = ,122, exec, pamixer -d 5 # Volume lower key
bind = ,123, exec, pamixer -i 5 # Volume Higher key
bind = ,256, exec, pamixer --default-source -t # Mic mute key
bind = ,232, exec, brightnessctl set 10%- # Screen brightness down FN+F7
bind = ,233, exec, brightnessctl set 10%+ # Screen brightness up FN+F8
bind = ,237, exec, brightnessctl -d asus::kbd_backlight set 33%- # Keyboard brightness down FN+F2
bind = ,238, exec, brightnessctl -d asus::kbd_backlight set 33%+ # Keyboard brightnes up FN+F3
bind = ,210, exec, asusctl led-mode -n # Switch keyboard RGB profile FN+F4

bind = SUPER,Z,hy3:makegroup,tab
bind = SUPER,U,hy3:makegroup,h
bind = SUPER,Y,hy3:makegroup,v
bind = SUPER,N,exec,pypr toggle term && hyprctl dispatch bringactivetotop
#-- Startup ----------------------------------------------------
exec-once=~/.config/hypr/scripts/startup
# exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
# exec-once=systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
# Screensharing
exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
exec-once=hyprctl setcursor Catppuccin-Mocha-Dark-Cursors 24
exec-once = wl-paste --type text --watch cliphist store #Stores only text data
exec-once = wl-paste --type image --watch cliphist store #Stores only image data
# exec-once = swayidle -w timeout 300 '/home/philopater/.config/hypr/scripts/lockscreen' timeout 600 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on'
'';
};
  home.stateVersion = "23.05";
}
