{
  programs.nixvim = {
    opts = {
      showcmdloc = "statusline";
    };

    plugins.lualine = {
      enable = true;
      settings = {
        sections.lualine_c = [
          {
            __unkeyed-1.__raw = ''
              function()
                return require('auto-session.lib').current_session_name(true)
              end
            '';
          }
          "filename"
          "%S" # https://github.com/nvim-lualine/lualine.nvim/issues/1108
        ];

        options = {
          ignore_focus = [
            "neo-tree"
            "mini-files"
          ];
        };
      };
    };
  };
}
