{ config, pkgs, ... }:

{

  home.username = "yoyomanzoor";
  home.homeDirectory = "/home/yoyomanzoor";

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    # hello # package that prints hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # (writeShellScriptBin {
    #   name = "fuzzel-emoji";
    #   text = ./scripts/fuzzel-emoji;
    # })
    # (writeShellScriptBin "fuzzel-emoji" (builtins.readFile ./scripts/fuzzel-emoji))
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.git = {
    enable = true;
    userName = "yoyomanzoor-NixOS";
    userEmail = "smanzoor@umich.edu";
  };

  # Stylix settings
  stylix = {
    enable = true;
    autoEnable = true;
    targets = {
      alacritty.enable = true;
      avizo.enable = true;
      bat.enable = true;
      firefox.enable = true;
      fish.enable = true;
      fuzzel.enable = true;
      fzf.enable = true;
      # gnome.enable = true;
      gtk.enable = true;
      kde.enable = true;
      kitty.enable = true;
      kitty.variant256Colors = true;
      lazygit.enable = true;
      neovim.enable = true;
      neovim.transparentBackground.main = true;
      qutebrowser.enable = true;
      sway.enable = true;
      swaylock.enable = true;
      swaync.enable = true;
      tmux.enable = true;
      vesktop.enable = true;
      vscode.enable = true;
      waybar.enable = true;
      wofi.enable = true;
      xfce.enable = true;
      zathura.enable = true;
    };

    image = ./wallpaper.png;
    # https://tinted-theming.github.io/base16-gallery/
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${config.theme.theme}.yaml";
    polarity = "dark"; # light or dark or either
    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata-Modern-Ice";
    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
    opacity = {
      applications = 0.9;
      terminal = 0.9;
      desktop = 1.0;
      popups = 0.9;
    };
  };

  services = {
    avizo.enable = true;
    swaync.enable = true;
  };

  programs = {
    # alacritty.enable = true;
    bat.enable = true;
    firefox.enable = true;
    fuzzel.enable = true;
    lazygit.enable = true;
    # qutebrowser.enable = true;
    swaylock.enable = true;
    # vscode.enable = true;
    direnv = {
      enable = true;
      # enableFishIntegration = true; # Not needed for Fish
      nix-direnv.enable = true;
    };
    zoxide.enable = true;
  };

  gtk.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./theme.nix
    # ./dotfiles/ankitheme.nix
    ./dotfiles/fish.nix
    ./dotfiles/fzf.nix
    ./dotfiles/helix.nix
    # ./dotfiles/hyprland/hyprland.nix
    ./dotfiles/kitty.nix
    ./dotfiles/nixvim/nixvim.nix
    # ./dotfiles/nixvim/neve.nix # alternative neovim config
    ./dotfiles/sway/sway.nix
    ./dotfiles/swaync/swaync.nix
    ./dotfiles/tmux.nix
    ./dotfiles/waybar.nix
    # ./dotfiles/wezterm.nix # konsole is better for arabic in vim
    ./dotfiles/wlogout/wlogout.nix
    ./dotfiles/wofi.nix
    ./dotfiles/vieb/vieb.nix
    ./dotfiles/vim.nix
    ./dotfiles/vimiv/vimiv.nix
    ./dotfiles/zathura.nix
    # TODO: Ranger
  ];
}
