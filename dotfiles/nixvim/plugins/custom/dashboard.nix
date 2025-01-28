{
  programs.nixvim.plugins.dashboard = {
    enable = true;
    settings = {
      theme = "doom";
      config = {
        header = [
          ""
          ""
          ""
          ""
          "/\\   __                                "
          "\\ \\_/ /__  _   _  ___/\\  /🪀 _ __ ___  "
          " \\   / _ \\| | | |/ _ \\ \\/ / | '_ ` _ \\ "
          "  | | (_) | |_| | (_) \\  /| | | | | | |"
          "  |_|\\___/ \\__, |\\___/ \\/ |_|_| |_| |_|"
          "__________  __/ |  ____________________"
          "           |___/                       "
          ""
        ];
        center = [
          # {
          #   action = {
          #     __raw = "function() vim.cmd('SessionSearch') end";
          #   };
          #   desc = "sessions";
          #   icon = "󰍹 ";
          #   key = "a";
          # }
          {
            action = {
              __raw = "function(path) vim.cmd('Telescope oldfiles') end";
            };
            desc = "recent files";
            icon = "󰌑 ";
            key = "a";
          }
          {
            action = {
              __raw = "function(path) vim.cmd('Telescope find_files') end";
            };
            desc = "directory";
            icon = " ";
            icon_hl = "@variable";
            key = "s";
          }
          {
            action = {
              __raw = "function(path) vim.cmd('Telescope find_files hidden=true cwd=~') end";
            };
            desc = "files";
            icon = "󰈔 ";
            icon_hl = "@variable";
            key = "d";
          }
          {
            action = {
              __raw = "function(path) vim.cmd('Ranger') end";
            };
            desc = "ranger";
            icon = "󱡁 ";
            icon_hl = "@variable";
            key = "f";
          }
        ];
        footer = [ "Yoyo 󱄅 Manzoor" ];
      };
      hide.tabline = true;
    };
  };
}
