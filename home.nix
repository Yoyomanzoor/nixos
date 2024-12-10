{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "yoyomanzoor";
  home.homeDirectory = "/home/yoyomanzoor";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
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

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/yoyomanzoor/etc/profile.d/hm-session-vars.sh
  #
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
      fish.enable = true;
      gnome.enable = true;
      kitty.enable = true;
      waybar.enable = true;
    };

    image = ./wallpaper.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
    polarity = "dark"; # light or dark or either
    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata-Modern-Ice";
    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./dotfiles/swaync/swaync.nix
    ./dotfiles/kitty/kitty.nix
    ./dotfiles/sway/sway.nix
  ];
}
