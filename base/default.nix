{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.home-manager.nixosModules.default
    ./virt-manager.nix
  ];

  # this allows you to access `pkgsUnstable` anywhere in your config
  _module.args.pkgsUnstable = import inputs.nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
    inherit (config.nixpkgs) config;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
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
    kitty
    ranger
    ueberzugpp

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
    lazygit
    any-nix-shell

    # languages
    lua
    gcc
    libgcc
    cargo
    python39
    nodejs_22

    # extra terminal for Arabic/bidi
    kdePackages.konsole

    # pkgsUnstable.neovim # Moved to home manager
    # markdown-oxide # required as a package for mason

    # apps
    vimiv-qt
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yoyomanzoor = {
    isNormalUser = true;
    description = "Yoyomanzoor";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "input"
      "libvirtd"
      "kvm"
    ];
    # openssh.authorizedKeys.keyFiles = [
    #   ~/.ssh
    # ];
    shell = pkgs.fish;
    packages = with pkgs; [
      # tools
      yt-dlp
      slides
      zathura
      mpv
      vimpc
      vlc
      vimpager

      # Ranger tools
      atool
      libarchive
      p7zip
      unrar
      poppler_utils # for pdf rendering
      exiftool
      transmission_4
      odt2txt
      pandoc
      xlsx2csv
      mediainfo

      # web
      floorp
      vieb
      w3m
      vimb

      # studying
      anki-bin
      obsidian

      # communication
      vesktop
      telegram-desktop
      whatsie
    ];
  };

  # Programming programs
  programs.fish.enable = true;
  programs.npm.enable = true;
  programs.tmux.enable = true;

  # Other programs
  programs.thunar.enable = true;
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
    extraSpecialArgs = {
      inherit inputs;
    };
    users = {
      "yoyomanzoor" = import ../home.nix;
    };
  };

  # Stylix settings
  stylix = {
    enable = true;
    autoEnable = true;
    targets = {
      #     fish.enable = true;
      gnome.enable = true;
      plymouth.enable = true;
    };

    image = ../wallpaper.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${config.theme.theme}.yaml";
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
