{ pkgs, lib, ... }: {
  programs.nixvim = {
    extraConfigLuaPre = ''
      local slow_format_filetypes = {}

      vim.api.nvim_create_user_command("FormatDisable", function(args)
         if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })
      vim.api.nvim_create_user_command("FormatToggle", function(args)
        if args.bang then
          -- Toggle formatting for current buffer
          vim.b.disable_autoformat = not vim.b.disable_autoformat
        else
          -- Toggle formatting globally
          vim.g.disable_autoformat = not vim.g.disable_autoformat
        end
      end, {
        desc = "Toggle autoformat-on-save",
        bang = true,
      })
    '';

    # Dependencies
    #
    # https://nix-community.github.io/nixvim/NeovimOptions/index.html?highlight=extraplugins#extrapackages
    extraPackages = with pkgs; [
      # Used to format Lua code
      stylua
    ];

    # Autoformat
    # https://nix-community.github.io/nixvim/plugins/conform-nvim.html
    plugins.conform-nvim = {
      enable = true;
      settings = {
        log_level = "warn";
        notify_on_error = false;
        notify_no_formatters = false;
        formatters = {
          black = {
            command = lib.getExe pkgs.black;
          };
          isort = {
            command = lib.getExe pkgs.isort;
          };
          shellcheck = {
            command = lib.getExe pkgs.shellcheck;
          };
          shfmt = {
            command = lib.getExe pkgs.shfmt;
          };
          shellharden = {
            command = lib.getExe pkgs.shellharden;
          };
          squeeze_blanks = {
            command = lib.getExe' pkgs.coreutils "cat";
          };
          gofumpt = {
            command = lib.getExe pkgs.gofumpt;
          };
          prettierd = {
            command = lib.getExe pkgs.prettierd;
          };
          jq = {
            command = lib.getExe pkgs.jq;
          };
          nixfmt-rfc-style = {
            command = lib.getExe pkgs.nixfmt-rfc-style;
          };
          cbfmt = {
            command = lib.getExe pkgs.cbfmt;
          };
          superhtml = {
            command = lib.getExe pkgs.superhtml;
          };
          rubyfmt = {
            command = lib.getExe pkgs.rubyfmt;
          };
          rustfmt = {
            command = lib.getExe pkgs.rustfmt;
          };
        };
        formatters_by_ft = {
          bash = [ "shellcheck" "shellharden" "shfmt" ]; # Conform runs formatters sequentially
          cpp = [ "clang_format" ];
          go = [ "gofumpt" ];
          html = [ [ "prettierd" "prettier" ] "superhtml" ];
          javascript = [ [ "prettierd" "prettier" ] ]; # Sublist runs until a formatter is found
          json = [ "jq" ];
          # latex = [ "latexindnet" ];
          lua = ["stylua"];
          markdown = [ [ "prettierd" "prettier" ] "cbfmt" ];
          nix = [ "nixfmt-rfc-style" ];
          python = [ "isort" "black" ];
          ruby = [ "rubyfmt" ];
          rust = [ "rustfmt" ];
          typescript = [ [ "prettierd" "prettier" ] ];
          yaml = [ "prettierd" "prettier" ];
          "_" = [ "squeeze_blanks" "trim_whitespace" "trim_newlines" ];
        };
        format_on_save = ''
          function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
              return
            end

            if slow_format_filetypes[vim.bo[bufnr].filetype] then
              return
            end

            local function on_format(err)
              if err and err:match("timeout$") then
                slow_format_filetypes[vim.bo[bufnr].filetype] = true
              end
            end

            return { timeout_ms = 200, lsp_fallback = true }, on_format
          end
        '';
        function_after_save = ''
          function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
              return
            end

            if not slow_format_filetypes[vim.bo[bufnr].filetype] then
              return
            end

            return { lsp_fallback = true }
          end
        '';
      };
    };

    # https://nix-community.github.io/nixvim/keymaps/index.html
    keymaps = [
      {
        mode = "n";
        key = "<leader>fc";
        action.__raw = ''
          function()
            require('conform').format { async = true, lsp_fallback = true }
          end
          '';
        options = {
          desc = "[F]ormat buffer [C]onform";
        };
      }
    ];
  };
}
