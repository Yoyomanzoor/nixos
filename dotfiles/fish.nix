{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    nvd
    fishPlugins.fzf-fish
    fishPlugins.autopair
  ];

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fish = {
    enable = true;
    functions = {
      fish_greeting.body = "fastfetch";
      nix-switch.body = ''
        sudo nixos-rebuild switch --flake ~/.config/nixos#lenovo-nanoX1-wayland && nvd diff (find /nix/var/nix/profiles/ -name "system-*-link" | sort -rn -t "-" -k 2 | head -2 | tac)
      '';
      nix-boot.body = ''
        sudo nixos-rebuild boot --flake ~/.config/nixos#lenovo-nanoX1-wayland && nvd diff (find /nix/var/nix/profiles/ -name "system-*-link" | sort -rn -t "-" -k 2 | head -2 | tac)
      '';
    };
    interactiveShellInit = ''
      starship init fish | source
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
    '';
    shellAliases = {
      cd = "z";
      ls = "eza -al --color=always --group-directories-first --icons=auto"; # preferred listing
      la = "eza -a --color=always --group-directories-first --icons=auto";
      ll = "eza -lha --color=always --group-directories-first --icons=auto --sort=name";
      lt = "eza --icons=auto --tree";
      ltt = "eza -aT --color=always --group-directories-first --icons=auto";
      "l." = "eza -ald --color=always --group-directories-first --icons=auto .*";
      cat = "bat";
      big = "expac -H M '%m\t%n' | sort -h | nl";
      dir = "dir --color=auto";
      grep = "ugrep --color=auto";
      egrep = "ugrep -E --color=auto";
      fgrep = "ugrep -F --color=auto";
      hw = "hwinfo --short";
      ip = "ip -color";
      psmem = "ps auxf | sort -nr -k 4";
      psmem10 = "ps auxf | sort -nr -k 4 | head -10";
      tarnow = "tar -acf ";
      untar = "tar -zxvf ";
      vdir = "vdir --color=auto";
      wget = "wget -c ";
      vim = "nvim";
      v = "nvim";
      n = "nvim";
      conda = "micromamba";
      r = "R_AUTO_START=true nvim";
      mpvm = "mpv --no-video ";
      jctl = "journalctl -p 3 -xb";
      rip = "expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl";
    };
    shellAbbrs = {
      ".." = "z ..";
      "..." = "z ../..";
      ".3" = "z ../../..";
      ".4" = "z ../../../..";
      ".5" = "z ../../../../..";
      mkdir = "mkdir -p";
    };
    preferAbbrs = true;
  };
}
