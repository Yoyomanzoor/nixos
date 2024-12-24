{ config, ... }:
{
  xdg.configFile."vimiv/keys.conf".source = ./keys.conf;
  xdg.configFile."vimiv/vimiv.conf".source = ./vimiv.conf;
  xdg.configFile."vimiv/styles/stylix" = {
    text = ''
      ; This file is a reference for creating own styles. It will never be read.
      ; To change values, copy this file using a new name and set the style setting
      ; in vimiv.conf to that name.
      [STYLE]
      base00 = #${config.lib.stylix.colors.base00}
      base01 = #${config.lib.stylix.colors.base01}
      base02 = #${config.lib.stylix.colors.base02}
      base03 = #${config.lib.stylix.colors.base03}
      base04 = #${config.lib.stylix.colors.base04}
      base05 = #${config.lib.stylix.colors.base05}
      base06 = #${config.lib.stylix.colors.base06}
      base07 = #${config.lib.stylix.colors.base07}
      base08 = #${config.lib.stylix.colors.base08}
      base09 = #${config.lib.stylix.colors.base09}
      base0a = #${config.lib.stylix.colors.base0A}
      base0b = #${config.lib.stylix.colors.base0B}
      base0c = #${config.lib.stylix.colors.base0C}
      base0d = #${config.lib.stylix.colors.base0D}
      base0e = #${config.lib.stylix.colors.base0E}
      base0f = #${config.lib.stylix.colors.base0F}
      font = 10pt Monospace
      image.bg = #${config.lib.stylix.colors.base00}
      image.scrollbar.width = 8px
      image.scrollbar.bg = #${config.lib.stylix.colors.base00}
      image.scrollbar.fg = #${config.lib.stylix.colors.base03}
      image.scrollbar.padding = 2px
      library.font = 10pt Monospace
      library.fg = #${config.lib.stylix.colors.base06}
      library.padding = 2px
      library.directory.fg = #${config.lib.stylix.colors.base07}
      library.even.bg = #${config.lib.stylix.colors.base01}
      library.odd.bg = #${config.lib.stylix.colors.base01}
      library.selected.bg = #${config.lib.stylix.colors.base0D}
      library.selected.fg = #${config.lib.stylix.colors.base07}
      library.search.highlighted.fg = #${config.lib.stylix.colors.base01}
      library.search.highlighted.bg = #${config.lib.stylix.colors.base04}
      library.scrollbar.width = 8px
      library.scrollbar.bg = #${config.lib.stylix.colors.base00}
      library.scrollbar.fg = #${config.lib.stylix.colors.base03}
      library.scrollbar.padding = 2px
      library.border = 0px solid
      statusbar.font = 10pt Monospace
      statusbar.bg = #${config.lib.stylix.colors.base02}
      statusbar.fg = #${config.lib.stylix.colors.base06}
      statusbar.error = #${config.lib.stylix.colors.base08}
      statusbar.warning = #${config.lib.stylix.colors.base09}
      statusbar.info = #${config.lib.stylix.colors.base0C}
      statusbar.message_border = 2px solid
      statusbar.padding = 4
      thumbnail.font = 10pt Monospace
      thumbnail.fg = #${config.lib.stylix.colors.base06}
      thumbnail.bg = #${config.lib.stylix.colors.base00}
      thumbnail.padding = 20
      thumbnail.selected.bg = #${config.lib.stylix.colors.base0D}
      thumbnail.search.highlighted.bg = #${config.lib.stylix.colors.base04}
      thumbnail.default.bg = #${config.lib.stylix.colors.base0C}
      thumbnail.error.bg = #${config.lib.stylix.colors.base08}
      thumbnail.frame.fg = #${config.lib.stylix.colors.base06}
      completion.height = 16em
      completion.fg = #${config.lib.stylix.colors.base06}
      completion.even.bg = #${config.lib.stylix.colors.base02}
      completion.odd.bg = #${config.lib.stylix.colors.base02}
      completion.selected.fg = #${config.lib.stylix.colors.base07}
      completion.selected.bg = #${config.lib.stylix.colors.base0D}
      keyhint.padding = 2px
      keyhint.border_radius = 10px
      keyhint.suffix_color = #${config.lib.stylix.colors.base0C}
      manipulate.fg = #${config.lib.stylix.colors.base06}
      manipulate.focused.fg = #${config.lib.stylix.colors.base0C}
      manipulate.bg = #${config.lib.stylix.colors.base00}
      manipulate.slider.left = #${config.lib.stylix.colors.base0D}
      manipulate.slider.handle = #${config.lib.stylix.colors.base04}
      manipulate.slider.right = #${config.lib.stylix.colors.base02}
      manipulate.image.border = 2px solid
      manipulate.image.border.color = #${config.lib.stylix.colors.base0C}
      mark.color = #${config.lib.stylix.colors.base0E}
      keybindings.bindings.color = #${config.lib.stylix.colors.base0C}
      keybindings.highlight.color = #${config.lib.stylix.colors.base0E}
      metadata.padding = 2px
      metadata.border_radius = 10px
      image.straighten.color = #${config.lib.stylix.colors.base0A}
      prompt.font = 10pt Monospace
      prompt.fg = #${config.lib.stylix.colors.base06}
      prompt.bg = #${config.lib.stylix.colors.base02}
      prompt.padding = 2px
      prompt.border_radius = 10px
      prompt.border = 2px solid
      prompt.border.color = #${config.lib.stylix.colors.base0C}
      crop.shading = #88000000
      crop.border = 2px solid
      crop.border.color = #88AAAAAA
      crop.grip.color = #88FFFFFF
      crop.grip.border = 2px solid
      crop.grip.border.color = #88AAAAAA
      library.selected.bg.unfocus = #8881a2be
      thumbnail.selected.bg.unfocus = #8881a2be
      metadata.bg = #AAd6d6d6

      ; vim:ft=dosini
    '';
  };
}
