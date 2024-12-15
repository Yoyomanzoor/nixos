{
  programs.nixvim.plugins.dashboard = {
    enable = true;
    settings = {
      theme = "doom";
      config = {
        header = [
          "/\\   __                                "
          "\\ \\_/ /__  _   _  ___/\\  /🪀 _ __ ___  "
          " \\   / _ \\| | | |/ _ \\ \\/ / | '_ ` _ \\ "
          "  | | (_) | |_| | (_) \\  /| | | | | | |"
          "  |_|\\___/ \\__, |\\___/ \\/ |_|_| |_| |_|"
          "__________  __/ |  ____________________"
          "           |___/                       "
        ];
        center = [
          {
            action = {
              __raw = "function() vim.cmd('SessionSearch') end";
            };
            desc = "sessions";
            icon = "󰍹 ";
            key = "a";
          }
          {
            action = {
              __raw = "function(path) vim.cmd('Telescope oldfiles') end";
            };
            desc = "recent files";
            icon = "󰌑 ";
            key = "s";
          }
          {
            action = {
              __raw = "function(path) vim.cmd('Telescope file_browser hidden=true') end";
            };
            desc = "files";
            icon = " ";
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
