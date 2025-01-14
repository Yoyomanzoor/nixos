{
  programs.nixvim = {
    plugins.hop.enable = true;
    keymaps = [
      # {
      #   key = "f";
      #   action.__raw = ''
      #     function()
      #       require('hop').hint_char1({
      #         direction = require('hop.hint').HintDirection.AFTER_CURSOR,
      #         current_line_only = true
      #       })
      #     end
      #   '';
      #   options.remap = true;
      # }
      # {
      #   key = "F";
      #   action.__raw = ''
      #     function()
      #       require('hop').hint_char1({
      #         direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
      #         current_line_only = true
      #       })
      #     end
      #   '';
      #   options.remap = true;
      # }
      {
        key = "<leader>jj";
        action = "<cmd>HopWord<CR>";
        options = {
          desc = "[J]ump to word";
        };
      }
      {
        key = "<leader>jl";
        action = "<cmd>HopLineStart<CR>";
        options = {
          desc = "[J]ump to [L]ine";
        };
      }
      {
        key = "<leader>jn";
        action = "<cmd>HopNodes<CR>";
        options = {
          desc = "[J]ump to [L]ine";
        };
      }
    ];
  };
}
