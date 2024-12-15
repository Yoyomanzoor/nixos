{ config, ... }: {
  programs.nixvim = {
    plugins.undotree = {
      enable = true;
    };
    opts = {
      undodir = "${config.xdg.configHome}/.local/share/nvim/undodir";
    };
    keymaps = [
      {
        mode = "n";
        key = "<F5>";
        action = "<cmd>UndotreeToggle<CR>";
      }
    ];
  };
}
