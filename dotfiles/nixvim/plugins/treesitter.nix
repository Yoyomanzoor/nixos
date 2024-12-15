{
  programs.nixvim = {
    # Highlight, edit, and navigate code
    # https://nix-community.github.io/nixvim/plugins/treesitter/index.html
    plugins.treesitter = {
      enable = true;

      # TODO: Don't think I need this as nixGrammars is true which should auto install these???
      settings = {
        ensureInstalled = [
          # https://github.com/tree-sitter/tree-sitter/wiki/List-of-parsers
          "asm"
          "bash"
          "c"
          "cmake"
          "cpp"
          "css"
          "csv"
          "diff"
          "fish"
          "git_config"
          "git_rebase"
          "gitattributes"
          "gitcommit"
          "gitignore"
          "html"
          "hyprlang"
          "javascript"
          "json"
          "lua"
          "luadoc"
          "matlab"
          "markdown"
          "markdown_inline"
          "nix"
          "perl"
          "python"
          "query"
          "r"
          "regex"
          "ruby"
          "scss"
          "sql"
          "vim"
          "vimdoc"
          "xml"
          "yaml"
          "zathurarc"
        ];

        highlight = {
          enable = true;

          # Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
          additional_vim_regex_highlighting = true;
        };

        indent = {
          enable = true;
          disable = [
            "ruby"
          ];
        };

        incremental-selection = {
          enable = true;
          keymaps = {
            init_selection = "<S-Space>";
            node_incremental = "<S-Space>";
            node_decremental = "<bs>";
            scope_incremental = false;
          };
        };

        # There are additional nvim-treesitter modules that you can use to interact
        # with nvim-treesitter. You should go explore a few and see what interests you:
        #
        #    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
        #    - Show your current context: https://nix-community.github.io/nixvim/plugins/treesitter-context/index.html
        #    - Treesitter + textobjects: https://nix-community.github.io/nixvim/plugins/treesitter-textobjects/index.html
      };
    };
  };
}
