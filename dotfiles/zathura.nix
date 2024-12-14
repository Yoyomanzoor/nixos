{ config, pkgs, ... }:

{
  programs.zathura = {
    enable = true;
    mappings = {
      j = "feedkeys '<C-Down>'";
      k = "feedkeys '<C-Up>'";
    };
    options = {
      guioptions = "vc";
      statusbar-h-padding = 0;
      statusbar-v-padding = 0;
      page-padding = 10;
      scroll-step = 40;
      selection-keyboard = "clipboard";
      recolor-keephue = true;
    };
  };
}
