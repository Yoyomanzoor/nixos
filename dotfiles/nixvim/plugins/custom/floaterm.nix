{
  programs.nixvim = {
    plugins.floaterm = {
      enable = true;
      width = 0.9;
      height = 0.9;

      keymaps = {
        toggle = "<leader>tt";
        new = "<leader>tn";
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>gg";
        action.__raw = ''
          function()
            vim.cmd('lcd %:p:h')
            vim.cmd('FloatermNew --autoclose=1 lazygit')
          end
        '';
        options = {
          desc = "[G]it [G]ud";
        };
      }
    ];
  };
}
