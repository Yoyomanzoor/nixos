{
  programs.nixvim = {
    # Useful plugin to show you pending keybinds.
    # https://nix-community.github.io/nixvim/plugins/which-key/index.html
    plugins.which-key = {
      enable = true;

      # Document existing key chains
      settings = {
        spec = [
          {
            __unkeyed-1 = "<leader>a";
            group = "[A]utosession";
          }
          {
            __unkeyed-1 = "<leader>b";
            group = "[B]uffer";
          }
          {
            __unkeyed-1 = "<leader>c";
            group = "[C]ode";
          }
          {
            __unkeyed-1 = "<leader>d";
            group = "[D]ocument";
          }
          {
            __unkeyed-1 = "<leader>f";
            group = "[F]ind";
          }
          {
            __unkeyed-1 = "<leader>g";
            group = "[G]it";
          }
          {
            __unkeyed-1 = "<leader>h";
            group = "Git [H]unk";
            mode = [
              "n"
              "v"
            ];
          }
          {
            __unkeyed-1 = "<leader>n";
            group = "[N]otifications";
          }
          {
            __unkeyed-1 = "<leader>p";
            group = "[P]aste";
          }
          {
            __unkeyed-1 = "<leader>r";
            group = "[R]ename";
          }
          {
            __unkeyed-1 = "<leader>s";
            group = "[S]earch";
          }
          {
            __unkeyed-1 = "<leader>t";
            group = "[T]oggle";
          }
          {
            __unkeyed-1 = "<leader>w";
            group = "[W]eb";
          }
          {
            __unkeyed-1 = "<leader>y";
            group = "[Y]ank";
          }
        ];
      };
    };
  };
}
