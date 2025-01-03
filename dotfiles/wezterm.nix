{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        front_end = "WebGpu",
        enable_wayland = true,
        bidi_enabled = true
      }
    '';
  };
}
