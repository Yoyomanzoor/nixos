{
  programs.nixvim = {
    # options.completeopt = ["menu" "menuone" "noselect"];
    plugins = {
      luasnip.enable = true;

      lspkind = {
        enable = true;

        cmp = {
          enable = true;
          menu = {
            nvim_lsp = "[LSP]";
            nvim_lua = "[api]";
            path = "[path]";
            luasnip = "[snip]";
            buffer = "[buffer]";
            neorg = "[neorg]";
            cmp_tabnine = "[TabNine]";
          };
        };
      };


      cmp = {
        enable = true;

        settings = {
          snippet.expand = "luasnip";

          completion = {
            completeopt = "menu,menuone,noinsert";
          };

          mapping = {
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<A-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.close()";
            "<Tab>" = "cmp.mapping.select_next_item()";
            "<S-Tab>" = "cmp.mapping.select_prev_item()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
          };

          sources = [
            {name = "path";}
            {name = "nvim_lsp";}
            {name = "luasnip";}
            {
              name = "buffer";
              # Words from other open buffers can also be suggested.
              option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
            }
            {name = "neorg";}
            {name = "path";}
            {name = "cmdline";}
            {name = "spell";}
          ];
        };

        cmdline = let
          search_config = {
            mapping = {__raw = "cmp.mapping.preset.cmdline()";};
            sources = [{name = "buffer";}];
          };
        in {
          "/" = search_config;
          "?" = search_config;
          ":" = {
            mapping = {__raw = "cmp.mapping.preset.cmdline()";};
            sources = [
              {name = "cmdline";}
            ];
          };
        };

      };
    };

  };
}
