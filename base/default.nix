# Base packages

{ config, pkgs, pkgsUnstable, lib, inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  # this allows you to access `pkgsUnstable` anywhere in your config
  _module.args.pkgsUnstable = import inputs.nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
    inherit (config.nixpkgs) config;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  hardware.bluetooth.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "caps:swapescape";
  };
  console.useXkbConfig = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # make /bin/bash work in scripts
  # system.activationScripts.binbash = {
  #   deps = [ "binsh" ];
  #   text = ''
  #        ln -s /bin/sh /bin/bash
  #   '';
  # };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # general environment
    nerdfonts
    blueman

    # command line tools
    acpi
    wget
    ripgrep
    jq
    unzip
    ugrep
    eza
    fzf
    fd
    bat
    fastfetch
    starship
    nix-search
    trashy
    killall

    # languages
    lua
    gcc
    libgcc
    cargo
    # python3
    nodejs_22

    # neovim
    pkgsUnstable.neovim
    markdown-oxide # required as a package for mason

    # apps
    vimiv-qt

  ];
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yoyomanzoor = {
    isNormalUser = true;
    description = "Yoyomanzoor";
    extraGroups = [ "networkmanager" "wheel" "video" "input" ];
    # openssh.authorizedKeys.keyFiles = [
    #   ~/.ssh
    # ];
    shell = pkgs.fish;
    packages = with pkgs; [
      kitty
      ranger
      floorp
      vieb
      lazygit
      zathura
      vesktop
      obsidian
      mpv
      vlc
      yt-dlp
      w3m
      slides
      ueberzugpp
      anki-bin
      dolphin
    ];
  };

  # Programming programs
  programs.fish.enable = true;
  programs.npm.enable = true;
  programs.tmux = {
    enable = true;
    clock24 = false;
    keyMode = "vi";
    shortcut = "Space";
    escapeTime = 0;
    # plugins = with pkgs; [ # have to be tmuxPlugins!
    #   tmuxPlugins.battery
    #   tmuxPlugins.weather
    #   tmuxPlugins.tmux-fzf
    #   tmuxPlugins.fzf-tmux-url
    #   tmuxPlugins.rose-pine
    # ];
    extraConfig = ''
      # Yoyomanzoor tmux config

      # set -g @plugin 'tmux-plugins/tmux-battery'
      set -g @plugin 'rose-pine/tmux'
      set -g @rose_pine_variant 'main' # Options are 'main', 'moon' or 'dawn'
      set -g @plugin 'xamut/tmux-weather'
      set -g @plugin 'sainnhe/tmux-fzf'
      set -g @plugin 'MunifTanjim/tmux-mode-indicator'

      ### Movement
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      ### Split
      unbind '"'
      unbind %
      bind s split-window -h -c "#{pane_current_path}"
      bind v split-window -v -c "#{pane_current_path}"

      ### Resize
      bind -n C-M-h resize-pane -L 10
      bind -n C-M-l resize-pane -R 10
      bind -n C-M-j resize-pane -D 10
      bind -n C-M-k resize-pane -U 10

      ### Mouse mode
      set -g mouse on

      ### FZF
      TMUX_FZF_LAUNCH_KEY="C-f"

      ### Battery
      # set -g status-right '#{weather} | #{battery_status_bg} Batt: #{battery_icon} #{battery_percentage} #{battery_remain} | %a %h-%d %I:%M %p'
      set -g @rose_pine_status_left_prepend_section '#{tmux_mode_indicator}'
      set -g @rose_pine_status_right_append_section "Battery: #(acpi | grep -o '[^ ]*%%') | %a %h-%d %I:%M %p"


      ### Load plugins for NixOS
      # literally the most annoying thing
      # see https://github.com/NixOS/nixpkgs/pull/36790 and https://discourse.nixos.org/t/configuring-tmux-plugins-in-configuration-nix/1991

      run-shell ${pkgs.tmuxPlugins.battery}/share/tmux-plugins/battery/battery.tmux
      run-shell ${pkgs.tmuxPlugins.weather}/share/tmux-plugins/weather/weather.tmux
      run-shell ${pkgs.tmuxPlugins.tmux-fzf}/share/tmux-plugins/tmux-fzf/tmux-fzf.tmux
      run-shell ${pkgs.tmuxPlugins.rose-pine}/share/tmux-plugins/rose-pine/rose-pine.tmux
      run-shell ${pkgs.tmuxPlugins.mode-indicator}/share/tmux-plugins/mode-indicator/mode-indicator.tmux
    '';
    # extraTmuxConf = "run-shell ${pkgs.tmuxPlugins.sidebar}/share/tmux-plugins/sidebar/sidebar.tmux";
  };

  # Other programs
  programs.firefox.enable = false;

  # System programs
  programs.nm-applet = {
    enable = true;
    indicator = true;
  };

  # Git options - some git configs are housed in home-manager in ../home.nix !
  programs.git = {
    enable = true;
    config = {
      init = {
        defaultBranch = "main";
      };
    };
    lfs = {
      enable = true;
    };
  };
  
  #Home manager setup
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "yoyomanzoor" = import ../home.nix;
    };
  };

  # Stylix settings
  stylix = {
  #   enable = true;
  #   autoEnable = true;
  #   targets = {
  #     fish.enable = true;
  #     gnome.enable = true;
  #   };

    image = ../wallpaper.png;
  #   base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
  #   polarity = "dark"; # light or dark or either
  #   cursor.package = lib.mkForce pkgs.bibata-cursors;
  #   cursor.name = "Bibata-Modern-Ice";
  #   fonts = {
  #     monospace = {
  #       package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
  #       name = "JetBrainsMono Nerd Font Mono";
  #     };
  #     sansSerif = {
  #       package = pkgs.dejavu_fonts;
  #       name = "DejaVu Sans";
  #     };
  #     serif = {
  #       package = pkgs.dejavu_fonts;
  #       name = "DejaVu Serif";
  #     };
  #     emoji = {
  #       package = pkgs.noto-fonts-color-emoji;
  #       name = "Noto Color Emoji";
  #     };
  #   };
  #   opacity = {
  #     applications = 0.9;
  #     terminal = 0.9;
  #     desktop = 1.0;
  #     popups = 0.9;
  #   };
  };
  # disabledModules = [ "${inputs.stylix}/modules/regreet/nixos.nix" ]; # See https://github.com/danth/stylix/issues/577

  #----=[ Fonts ]=----#
  # fonts = {
  #   enableDefaultPackages = true;
  #   packages = with pkgs; [ 
  #     (nerdfonts.override {fonts = [ "FiraCode" ]; })
  #     noto-fonts
  #     noto-fonts-emoji
  #     liberation_ttf
  #     fira-code
  #     fira-code-symbols
  #     dina-font
  #     proggyfonts
  #     # Persian Font
  #     # vazir-fonts
  #   ];

  #   # fontconfig = {
  #   #   defaultFonts = {
  #   #     serif = [  "Liberation Serif" "Vazirmatn" ];
  #   #     sansSerif = [ "Fira Code" "Vazirmatn" ];
  #   #     monospace = [ "Fira Code" ];
  #   #   };
  #   # };
  # };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  ### List services that you want to enable:
  
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
