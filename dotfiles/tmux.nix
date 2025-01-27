{ pkgs, ... }:

let
  tmux-easy-motion = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-easy-motion";
    version = "";
    src = pkgs.fetchFromGitHub {
      owner = "IngoMeyer441";
      repo = "tmux-easy-motion";
      rev = "3e2edbd0a3d9924cc1df3bd3529edc507bdf5934";
      hash = "sha256-wOIPq12OqqxLERKfvVp4JgLkDXnM0KKtTqRWMqj4rfs=";
    };
  };

  tmux-open = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-open";
    version = "";
    src = pkgs.fetchFromGitHub {
      owner = "tmux-plugins";
      repo = "tmux-open";
      rev = "763d0a852e6703ce0f5090a508330012a7e6788e";
      hash = "sha256-Thii7D21MKodtjn/MzMjOGbJX8BwnS+fQqAtYv8CjPc=";
    };
  };
in
{
  # home.packages = with pkgs; [
  # ];

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
      # {
      #   plugin = tmuxPlugins.weather;
      #   extraConfig = ''
      #     set-option -g status-right "#{weather}"
      #     run-shell "${pkgs.tmuxPlugins.weather}/share/tmux-plugins/weather/tmux-weather.tmux"
      #   '';
      # }
      tmuxPlugins.vim-tmux-navigator
      {
        plugin = tmuxPlugins.mode-indicator;
        # extraConfig = ''run-shell "${pkgs.tmuxPlugins.mode-indicator}/share/tmux-plugins/mode-indicator/mode_indicator.tmux"'';
      }
      {
        plugin = tmuxPlugins.tmux-fzf;
        extraConfig = ''
          run-shell "${pkgs.tmuxPlugins.tmux-fzf}/share/tmux-plugins/tmux-fzf/main.tmux"
        '';
      }
      {
        plugin = tmux-easy-motion;
        extraConfig = ''
          set -g @easy-motion-prefix g
          set -g @easy-motion-target-keys "fjghdkslarutyei"
          set -g @easy-motion-default-motion "bd-w"
          run-shell "${tmux-easy-motion}/share/tmux-plugins/tmux-easy-motion/easy_motion.tmux"
        '';
      }
      {
        plugin = tmux-open;
        extraConfig = ''
          set -g @open-S 'https://www.duckduckgo.com/?q='
          run-shell "${tmux-open}/share/tmux-plugins/tmux-open/open.tmux"
        '';
      }
      {
        plugin = tmuxPlugins.dracula;
        extraConfig = ''
          set -g @dracula-show-powerline true
          set -g @dracula-fixed-location "Chicago"
          set -g @dracula-plugins "weather"
          set -g @dracula-show-flags true
          set -g @dracula-show-left-icon session
          run-shell "${tmuxPlugins.dracula}/share/tmux-plugins/dracula/dracula.tmux"
        '';
      }
      # {
      #   plugin = tmuxPlugins.rose-pine;
      #   extraConfig = ''
      #     set -g @rose_pine_variant "main" # Options are 'main', 'moon' or 'dawn'
      #
      #     set -g @rose_pine_host "" # Enables hostname in the status bar
      #     set -g @rose_pine_date_time "%I:%M %p" # It accepts the date UNIX command format (man date for info)
      #     set -g @rose_pine_user "" # Turn on the username component in the statusbar
      #     set -g @rose_pine_directory "on" # Turn on the current folder component in the status bar
      #     set -g @rose_pine_bar_bg_disable "" # Disables background color, for transparent terminal emulators
      #     # If @rose_pine_bar_bg_disable is set to "on", uses the provided value to set the background color
      #     # It can be any of the on tmux (named colors, 256-color set, `default` or hex colors)
      #     # See more on http://man.openbsd.org/OpenBSD-current/man1/tmux.1#STYLES
      #     set -g @rose_pine_bar_bg_disabled_color_option "default"
      #     # set -g @rose_pine_only_windows "on" # Leaves only the window module, for max focus and space
      #     set -g @rose_pine_disable_active_window_menu "on" # Disables the menu that shows the active window on the left
      #     set -g @rose_pine_default_window_behavior "on" # Forces tmux default window list behaviour
      #     set -g @rose_pine_show_current_program "on" # Forces tmux to show the current running program as window name
      #     set -g @rose_pine_show_pane_directory "on" # Forces tmux to show the current directory as window name
      #     set -g @rose_pine_window_separator " " # Replaces the default `:` between the window number and name
      #     # These are not padded
      #     set -g @rose_pine_session_icon "" # Changes the default icon to the left of the session name
      #     set -g @rose_pine_current_window_icon "" # Changes the default icon to the left of the active window name
      #     set -g @rose_pine_folder_icon "" # Changes the default icon to the left of the current directory folder
      #     set -g @rose_pine_username_icon "" # Changes the default icon to the right of the hostname
      #     set -g @rose_pine_hostname_icon "󰒋" # Changes the default icon to the right of the hostname
      #     set -g @rose_pine_date_time_icon "󰃰" # Changes the default icon to the right of the date module
      #     set -g @rose_pine_window_status_separator "  " # Changes the default icon that appears between window names
      #     set -g @rose_pine_status_left_prepend_section "#{tmux_mode_indicator}"
      #
      #     run-shell "${tmuxPlugins.mode-indicator}/share/tmux-plugins/mode-indicator/mode_indicator.tmux"
      #     run-shell "${tmuxPlugins.rose-pine}/share/tmux-plugins/rose-pine/rose-pine.tmux"
      #   '';
      # }
    ];
    extraConfig = ''
      # Yoyomanzoor tmux config 

      # new window
      bind-key Enter new-window

      # vim motions
      setw -g status-keys vi
      setw -g mode-keys vi
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      # tmux modes
      unbind -T copy-mode-vi v
      bind C-v copy-mode
      bind C-p paste-buffer
      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi y send -X copy-selection
      bind -T copy-mode-vi Escape send -X cancel

      # Moving panes to other windows
      bind-key M choose-tree -Zw "join-pane -t '%%'"
      bind-key C-m choose-tree -Zs "join-pane -t '%%'"

      # Jump to last window
      bind-key C-Space last-window
      bind-key Space run-shell -b "${pkgs.tmuxPlugins.tmux-fzf}/share/tmux-plugins/tmux-fzf/scripts/window.sh switch"
      unbind "/"
      bind-key "/" run-shell -b "${pkgs.tmuxPlugins.tmux-fzf}/share/tmux-plugins/tmux-fzf/scripts/keybinding.sh"

      # Split
      unbind '"'
      unbind %
      bind-key v split-window -h -c "#(pane_current_path)"
      bind-key s split-window -v -c "#(pane_current_path)"
      bind-key C-V select-layout even-horizontal

      # Resize
      bind -n M-H resize-pane -L 10
      bind -n M-L resize-pane -R 10
      bind -n M-J resize-pane -D 10
      bind -n M-K resize-pane -U 10
      bind-key C-S select-layout even-vertical

      # fzf
      TMUX_FZF_LAUNCH_KEY="C-f"
      TMUX_FZF_SWITCH_CURRENT=1

      # For nvim-tmux-navigator
      bind-key -n 'C-Space' if-shell "$is_vim" 'send-keys C-Space' 'select-pane -t:.+'

      # styles
      set -g cursor-style blinking-bar
      set -g status-position top

    '';
  };
}
