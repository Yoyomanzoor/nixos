{ pkgs, ... }: {
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
    {
      plugin = ranger-nvim;
      config = ''
        lua << EOF
        local ranger_nvim = require("ranger-nvim")
        ranger_nvim.setup({
          replace_netrw = true,
          enable_cmds = true,
          keybinds = {
            ["ov"] = ranger_nvim.OPEN_MODE.vsplit,
            ["oh"] = ranger_nvim.OPEN_MODE.split,
            ["ot"] = ranger_nvim.OPEN_MODE.tabedit,
            ["or"] = ranger_nvim.OPEN_MODE.rifle,
          },
          ui = {
            border = "rounded",
            height = 0.8,
            width = 0.8,
            x = 0.5,
            y = 0.5,
          },
        })
        EOF
      '';
    }
    ];

    keymaps = [
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Ranger<CR>";
        options = {
          noremap = true;
          desc = "[F]ind [F]iles (with ranger)";
        };
      }
    ];
  };
}
