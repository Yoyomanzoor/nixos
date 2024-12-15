{
  programs.nixvim = {
    plugins.auto-session = {
      enable = true;
      settings = {
        bypass_save_filetypes = [ "dashboard" ];
        auto_restore = false;
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>af";
        action.__raw = ''
          function()
            vim.cmd("SessionSearch")
          end
        '';
        options = {
          desc = "[A]utoSession [F]ind";
        };
      }
      {
        mode = "n";
        key = "<leader>as";
        action.__raw = ''
          function()
            vim.cmd("SessionSave")
          end
        '';
        options = {
          desc = "[A]utoSession [S]ave";
        };
      }
      {
        mode = "n";
        key = "<leader>aa";
        action.__raw = ''
          function()
            vim.cmd("SessionToggleAutoSave")
          end
        '';
        options = {
          desc = "[A]utoSession toggle [A]utosave";
        };
      }
      {
        mode = "n";
        key = "<leader>ap";
        action.__raw = ''
          function()
            vim.cmd("SessionPurgeOrphaned")
          end
        '';
        options = {
          desc = "[A]utoSession [P]urge orphaned sessions";
        };
      }
    ];
  };
}
