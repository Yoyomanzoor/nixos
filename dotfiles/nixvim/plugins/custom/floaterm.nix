{
  programs.nixvim = {
    plugins.floaterm = {
      enable = true;
      settings = {
        width = 0.9;
        height = 0.9;
        keymap_new = "<leader>te";
        keymap_toggle = "<leader>tt";
        keymap_next = "<leader>tn";
        keymap_prev = "<leader>tp";
        keymap_kill = "<leader>tk";
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
