{
  programs.nixvim = {
    plugins.undotree = {
      enable = true;
    };
    opts = {
      undodir = "~/.vim/undodir";
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
