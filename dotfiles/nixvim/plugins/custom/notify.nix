{
  programs.nixvim= {
    plugins.notify = {
      enable = true;
      level = "warn";
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>ns";
        action.__raw = ''
          function()
            vim.cmd("Telescope notify")
          end
        '';
        options = {
          desc = "[N]otifications [S]how";
        };
      }
    ];
  };
}
