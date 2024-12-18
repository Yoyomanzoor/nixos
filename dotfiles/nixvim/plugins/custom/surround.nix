{
  programs.nixvim = {
    plugins.nvim-surround = {
      enable = true;
      settings = {
        aliases = {
          "a" = ">";
          "b" = ")";
          "B" = "}";
          "r" = "]";
          "q" = [ "\"" "'" "`" ];
          "s" = [ "}" "]" ")" ">" "\"" "'" "`" ];
        };
        keymaps = {
          insert = "<C-g>s";
          insert_line = "<C-g>S";
          normal = "ys";
          normal_cur = "yss";
          normal_line = "yS";
          normal_cur_line = "ySS";
          visual = "S";
          visual_line = "gS";
          delete = "ds";
          change = "cs";
          change_line = "cS";
        };
        # surrounds.change = {
        #   replacement.__raw = ''
        #     function()
        #       local result = M.get_input("Enter the function name: ")
        #       if result then
        #         return { { result }, { "" } }
        #       end
        #     end
        #     '';
        #   target = "^<([^>]*)().-([^%/]*)()>$";
        # };
      };
    };
  };
}

