{ lib, config, pkgs, inputs, ... }: {
  
  imports = [ inputs.nix-colors.homeManagerModules.default ../spicetify.nix ];

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  home.username = "philopater";
  home.homeDirectory = "/home/philopater";
    home.packages = [
    pkgs.btop
    pkgs.k9s
    pkgs.bat
    pkgs.jetbrains-toolbox
    pkgs.zsh-vi-mode
    pkgs.gnome.nautilus
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
    pkgs.figlet
    pkgs.nms
    pkgs.cmatrix
    pkgs.tty-clock
    pkgs.lolcat
    pkgs.jq
    pkgs.nodePackages_latest.pnpm
    pkgs.fd
    pkgs.du-dust
    pkgs.skim
    pkgs.zellij
    pkgs.nodejs_20
    pkgs.cargo
    pkgs.sl
    pkgs.dotnet-sdk_7
    pkgs.oh-my-zsh
    pkgs.libsForQt5.qtstyleplugin-kvantum
    pkgs.qt6Packages.qtstyleplugin-kvantum
    pkgs.libsForQt5.qt5ct
    pkgs.lxqt.lxqt-panel
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
    pkgs.catppuccin-papirus-folders
    pkgs.fastfetch
    pkgs.nitch
    pkgs.pgcli
    pkgs.gitui
    pkgs.commitizen
    pkgs.signal-desktop
    pkgs.xdragon
    pkgs.element
    pkgs.tgpt
  ];
  nixpkgs.config.allowUnfree = true;
  home.sessionVariables = {
    EDITOR = "nvim";
    "QT_STYLE_OVERRIDE" = "kvantum";
    SHELL = "${pkgs.zsh}/bin/zsh";
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
    #platformTheme = "qtct";
    style.name = "kvantum";
  };
  programs.lf = {
     enable = true;
    commands = {
      dragon-out = ''%${pkgs.xdragon}/bin/xdragon -a -x "$fx"'';
      editor-open = ''$$EDITOR $f'';
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
      V = ''$${pkgs.bat}/bin/bat --paging=always --theme=gruvbox "$f"'';

      # ...
    };

    settings = {
      preview = true;
      hidden = true;
      drawbox = true;
      icons = true;
      ignorecase = true;
    };

    extraConfig = 
    let 
      previewer = 
        pkgs.writeShellScriptBin "pv.sh" ''
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
    in
    ''
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
      name = "Catppuccin-Mocha-Dark";
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
          home_symbol = " ~";
          style = "blue";
          truncate_to_repo = false;
          truncation_length = 5;
          truncation_symbol = ".../";
        };

        docker_context.symbol = " ";

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
          symbol = "❄️ ";
          format = "via [$symbol($name)]($style)";
        };
      };
    };
  };
  xdg.configFile."Kvantum/kvantum.kvconfig".source =
    (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
      General.theme = "Catppuccin-Mocha-Blue"; # "Catppuccin-Mocha-Mauve";
    };
  programs = {
    zsh = {
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
        source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
        eval "$(zoxide init zsh)"
        export EDITOR=nvim
      '';

      shellAliases = {
        ls = "eza -gl --git --color=automatic";
        ll = "eza -la --git --color=automatic";
        tree = "eza --tree";
        cat = "bat";

        ip = "ip --color";
        ipb = "ip --color --brief";

        gac = "git add -A  && git commit -a";
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
  home.stateVersion = "23.05";
}
