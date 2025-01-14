{
  programs.nixvim = {
    plugins.noice = {
      enable = true;
      # lazyLoad.enable = true;
      settings = {
        presets.bottom_search = true;
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>nd";
        action.__raw = ''
          function()
            vim.cmd("NoiceDismiss")
          end
        '';
        options = {
          desc = "[N]otification [D]elete";
        };
      }
    ];
  };
}
