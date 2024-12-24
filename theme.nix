{ lib, ... }:
with lib;
let
  defaultTheme = "hopscotch";
in
{
  options.theme.theme = mkOption {
    type = types.str;
    default = defaultTheme;
    description = "theme name";
  };
  config = {
    theme.theme = defaultTheme;
  };
}
