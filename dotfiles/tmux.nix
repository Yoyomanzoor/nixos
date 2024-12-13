{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    clock24 = true;
    baseIndex = 1;
    keyMode = "vi";
    mouse = true;
    shortcut = "Space";
    escapeTime = 0;
    terminal = "screen-256color";
    extraConfig = ''
      # Yoyomanzoor tmux config

      # set -g @plugin 'tmux-plugins/tmux-battery'
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
      set -g status-left '#{tmux_mode_indicator}'
      set -g status-right "Battery: #(acpi | grep -o '[^ ]*%%') | %a %h-%d %I:%M %p"


      ### Load plugins for NixOS
      # literally the most annoying thing
      # see https://github.com/NixOS/nixpkgs/pull/36790 and https://discourse.nixos.org/t/configuring-tmux-plugins-in-configuration-nix/1991

      run-shell ${pkgs.tmuxPlugins.battery}/share/tmux-plugins/battery/battery.tmux
      run-shell ${pkgs.tmuxPlugins.weather}/share/tmux-plugins/weather/weather.tmux
      run-shell ${pkgs.tmuxPlugins.tmux-fzf}/share/tmux-plugins/tmux-fzf/tmux-fzf.tmux
      run-shell ${pkgs.tmuxPlugins.mode-indicator}/share/tmux-plugins/mode-indicator/mode-indicator.tmux
    '';
    # extraTmuxConf = "run-shell ${pkgs.tmuxPlugins.sidebar}/share/tmux-plugins/sidebar/sidebar.tmux";
  };
}

