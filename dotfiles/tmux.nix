{ pkgs, ... }:

{
  home.packages = with pkgs; [

  ];

  programs.tmux = {
    enable = true;
    clock24 = true;
    baseIndex = 1;
    keyMode = "vi";
    mouse = true;
    shortcut = "Space";
    escapeTime = 0;
    terminal = "screen-256color";
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.weather;
        extraConfig = ''
          set-option -g status-right "#{weather}"
        '';
        # extraConfig = "run-shell ${pkgs.tmuxPlugins.weather}/share/tmux-plugins/weather/tmux-weather.tmux";
      }
      {
        plugin = tmuxPlugins.jump;
        extraConfig = "run-shell ${pkgs.tmuxPlugins.jump}/share/tmux-plugins/jump/tmux-jump.tmux";
      }
    ];
    extraConfig = ''
      # Yoyomanzoor tmux config

      ### Load plugins for NixOS
      # literally the most annoying thing
      # see https://github.com/NixOS/nixpkgs/pull/36790 and https://discourse.nixos.org/t/configuring-tmux-plugins-in-configuration-nix/1991

      # run-shell ${pkgs.tmuxPlugins.battery}/share/tmux-plugins/battery/battery.tmux
      # run-shell ${pkgs.tmuxPlugins.tmux-fzf}/share/tmux-plugins/tmux-fzf/tmux-fzf.tmux
      # run-shell ${pkgs.tmuxPlugins.mode-indicator}/share/tmux-plugins/mode-indicator/mode-indicator.tmux

      # set -g @plugin 'tmux-plugins/tmux-battery'
      # set -g @plugin 'xamut/tmux-weather'
      # set -g @plugin 'sainnhe/tmux-fzf'
      # set -g @plugin 'MunifTanjim/tmux-mode-indicator'

      ### Movement
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      bind -n C-M-h select-pane -L
      bind -n C-M-l select-pane -R
      bind -n C-M-k select-pane -U
      bind -n C-M-j select-pane -D

      bind C-M-J swap-pane -U
      bind C-M-K swap-pane -D

      # https://www.reddit.com/r/commandline/comments/8wv0w6/interactively_moving_panes_to_other_windows/
      bind-key M choose-tree -Zw "join-pane -t '%%'"
      bind-key C-m choose-tree -Zs "join-pane -t '%%'"


      ### Split
      unbind '"'
      unbind %
      bind v split-window -h -c "#{pane_current_path}"
      bind s split-window -v -c "#{pane_current_path}"

      ### Resize
      bind -n M-H resize-pane -L 10
      bind -n M-L resize-pane -R 10
      bind -n M-J resize-pane -D 10
      bind -n M-K resize-pane -U 10

      ### Mouse mode
      set -g mouse on

      ### FZF
      TMUX_FZF_LAUNCH_KEY="C-f"

      ### Battery
      # set -g status-right '#{weather} | #{battery_status_bg} Batt: #{battery_icon} #{battery_percentage} #{battery_remain} | %a %h-%d %I:%M %p'
      set -g status-left '#{tmux_mode_indicator}'
      # set -g status-right "#{weather} | Battery: #(acpi | grep -o '[^ ]*%%') | %a %h-%d %I:%M %p"
      set -g status-right "Battery: #(acpi | grep -o '[^ ]*%%') | %a %h-%d %I:%M %p"


    '';
    # extraTmuxConf = "run-shell ${pkgs.tmuxPlugins.sidebar}/share/tmux-plugins/sidebar/sidebar.tmux";
  };
}
