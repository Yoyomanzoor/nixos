{ pkgs, inputs, ... }:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./plugins/gitsigns.nix
    ./plugins/which-key.nix
    ./plugins/telescope.nix
    ./plugins/conform.nix
    ./plugins/lsp.nix
    ./plugins/nvim-cmp.nix
    ./plugins/mini.nix
    ./plugins/treesitter.nix

    ./plugins/kickstart
    ./plugins/custom
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    globals = {
      mapleader = " ";
      maplocalleader = " ";
      have_nerd_font = true;
    };

    opts = {
      number = true;
      relativenumber = true;
      mouse = "a";
      showmode = false;

      clipboard = {
        providers = {
          wl-copy.enable = true; # for wayland
          xsel.enable = false; # for X11
        };
        register = "unnamedplus";
      };

      breakindent = true;
      undofile = true;
      ignorecase = true;
      smartcase = true;
      signcolumn = "yes";
      updatetime = 250;
      timeoutlen = 300;
      splitright = true;
      splitbelow = true;

      list = true;
      # NOTE: .__raw here means that this field is raw lua code
      listchars.__raw = "{ tab = '» ', trail = '·', nbsp = '␣' }";

      # live preview substitutions
      inccommand = "split";

      cursorline = true;
      scrolloff = 10;
      hlsearch = true;

      # Yoyo edits
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      autoindent = true;
      encoding = "utf-8";
      colorcolumn = "80";
      termguicolors = true;
      conceallevel = 1;
      spelllang = "en_us";
      spell = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "Q";
        action = "<cmd>x<CR>";
      }
      {
        mode = "n";
        key = ";";
        action = ":";
      }
      {
        mode = "n";
        key = "<Esc";
        action = "<cmd>nohlsearch<CR>";
      }
      # NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
      # or just use <C-\><C-n> to exit terminal mode
      {
        mode = "t";
        key = "<Esc><Esc>";
        action = "<C-\\><C-n>";
        options = {
          desc = "Exit terminal mode";
        };
      }
      # Keybinds to make split navigation easier.
      #  Use CTRL+<hjkl> to switch between windows
      #
      #  See `:help wincmd` for a list of all window commands
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w><C-h>";
        options = {
          desc = "Move focus to the left window";
        };
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w><C-l>";
        options = {
          desc = "Move focus to the right window";
        };
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w><C-j>";
        options = {
          desc = "Move focus to the lower window";
        };
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w><C-k>";
        options = {
          desc = "Move focus to the upper window";
        };
      }

      {
        mode = "n";
        key = "<A-h>";
        action = "<cmd>vertical resize -5<CR>";
        options = {
          desc = "Resize left";
        };
      }
      {
        mode = "n";
        key = "<A-l>";
        action = "<cmd>vertical resize +5<CR>";
        options = {
          desc = "Resize right";
        };
      }
      {
        mode = "n";
        key = "<A-j>";
        action = "<cmd>resize +5<CR>";
        options = {
          desc = "Resize up";
        };
      }
      {
        mode = "n";
        key = "<A-k>";
        action = "<cmd>resize -5<CR>";
        options = {
          desc = "Resize down";
        };
      }
      {
        mode = "n";
        key = "<A-r>";
        action = "<C-w>=";
        options = {
          desc = "Resize down";
        };
      }

      {
        mode = "n";
        key = "<leader>bb";
        action = "<cmd>sp<CR>";
        options = {
          desc = "[B]uffer split";
        };
      }
      {
        mode = "n";
        key = "<leader>bv";
        action = "<cmd>vsp<CR>";
        options = {
          desc = "[B]uffer [V]ertical split";
        };
      }
      {
        mode = "n";
        key = "<leader>bh";
        action = "<C-w><S-h>";
        options = {
          desc = "[B]uffer move left";
        };
      }
      {
        mode = "n";
        key = "<leader>bl";
        action = "<C-w><S-l>";
        options = {
          desc = "[B]uffer move right";
        };
      }
      {
        mode = "n";
        key = "<leader>bj";
        action = "<C-w><S-j>";
        options = {
          desc = "[B]uffer move down";
        };
      }
      {
        mode = "n";
        key = "<leader>bk";
        action = "<C-w><S-k>";
        options = {
          desc = "[B]uffer move up";
        };
      }
      {
        mode = "n";
        key = "<leader>bo";
        action = "<C-w>o";
        options = {
          desc = "[B]uffer [O]nly";
        };
      }
      {
        mode = "n";
        key = "<leader>x";
        action = "bd";
        options = {
          desc = "Close buffer";
        };
      }

      {
        mode = "n";
        key = "<leader>sp";
        action.__raw = ''
          function()
            vim.opt.spell = not(vim.opt.spell:get())
          end
        '';
        options = {
          desc = "Toggle [Sp]ell check";
        };
      }

      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>y";
        action.__raw = ''
          '"+y'
        '';
        options.desc = "Copy to clipboard";
      }
      {
        mode = "n";
        key = "<leader>Y";
        action.__raw = ''
          '"+yg_'
        '';
        options.desc = "Copy to clipboard";
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>p";
        action.__raw = ''
          '"+p'
        '';
        options.desc = "Paste from clipboard";
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>P";
        action.__raw = ''
          '"+P'
        '';
        options.desc = "Paste from clipboard";
      }
    ];

    # https://nix-community.github.io/nixvim/NeovimOptions/autoGroups/index.html
    autoGroups = {
      kickstart-highlight-yank = {
        clear = true;
      };
    };

    # [[ Basic Autocommands ]]
    #  See `:help lua-guide-autocommands`
    # https://nix-community.github.io/nixvim/NeovimOptions/autoCmd/index.html
    autoCmd = [
      # Highlight when yanking (copying) text
      #  Try it with `yap` in normal mode
      #  See `:help vim.highlight.on_yank()`
      {
        event = [ "TextYankPost" ];
        desc = "Highlight when yanking (copying) text";
        group = "kickstart-highlight-yank";
        callback.__raw = ''
          function()
            vim.highlight.on_yank()
          end
        '';
      }
    ];

    plugins = {
      # Adds icons for plugins to utilize in ui
      web-devicons.enable = true;

      # Detect tabstop and shiftwidth automatically
      # https://nix-community.github.io/nixvim/plugins/sleuth/index.html
      sleuth = {
        enable = true;
      };

      # Highlight todo, notes, etc in comments
      # https://nix-community.github.io/nixvim/plugins/todo-comments/index.html
      todo-comments = {
        settings = {
          enable = true;
          signs = true;
        };
      };
    };

    # https://nix-community.github.io/nixvim/NeovimOptions/index.html?highlight=extraplugins#extraplugins
    extraPlugins = with pkgs; [
      # Useful for getting pretty icons, but requires a Nerd Font.
      vimPlugins.nvim-web-devicons # TODO: Figure out how to configure using this with telescope
      (vimUtils.buildVimPlugin {
        name = "w3m";
        src = fetchFromGitHub {
          owner = "yuratomo";
          repo = "w3m.vim";
          rev = "228a852b188f1a62ecea55fa48b0ec892fa6bad7";
          hash = "sha256-zv5WdkS5PouGQbsklZev8X3oIg3EWUhb10GBqm/0BjA=";
        };
      })
    ];

    # TODO: Figure out where to move this
    # https://nix-community.github.io/nixvim/NeovimOptions/index.html?highlight=extraplugins#extraconfigluapre
    extraConfigLuaPre = ''
      if vim.g.have_nerd_font then
        require('nvim-web-devicons').setup {}
      end
    '';

    # The line beneath this is called `modeline`. See `:help modeline`
    # https://nix-community.github.io/nixvim/NeovimOptions/index.html?highlight=extraplugins#extraconfigluapost
    extraConfigLuaPost = ''
      -- vim: ts=2 sts=2 sw=2 et
      -- vim.g["w3m#search_engine"] = "%s"
      vim.g["w3m#search_engine"] = "https://duckduckgo.com/?q=%s"
      vim.g["w3m#external_browser"] = "vieb"
      vim.keymap.set("n", "<leader>e", ":W3m ", { desc = "Search the web" })
      vim.keymap.set("n", "<leader>E", "<cmd>W3mAddressBar<CR>", { desc = "Open Address Bar" })
      vim.keymap.set("n", "<leader>wr", "<cmd>W3mReload<CR>", { desc = "[W]eb [R]eload" })
      vim.keymap.set("n", "<leader>wh", "<cmd>W3mHistory<CR>", { desc = "[W]eb [H]istory" })
      vim.keymap.set("n", "<leader>ws", ":W3mSplit ", { desc = "Search the web ([S]plit)" })
      vim.keymap.set("n", "<leader>wv", ":W3mVSplit ", { desc = "Search the web ([V]split)" })

      vim.keymap.set(
          "n",
          "<leader>we",
          vim.cmd("call w3m#ShowExternalBrowser()"),
          { desc = "open in [E]xternal browser (vieb)" }
      )

      vim.keymap.set("n", "<leader>wy", function()
          vim.cmd("call w3m#ShowURL()")
          local status_msg = vim.v.statusmsg
          local url = status_msg:match("w3m:%s*(.+)")
          if url then
              vim.fn.setreg("+", url)
          else
              print("Failed to print url")
          end
      end, { desc = "[W]eb [Y]ank URL" })

      -- vim.keymap.set("n", "<leader>ww", function()
      -- 	local clipboard_content = vim.fn.getreg("+")
      -- 	if clipboard_content == "" then
      -- 		print("Clipboard is empty, copy a URL fragment first")
      -- 		return
      -- 	end
      -- 	local url = "http://" .. clipboard_content
      -- 	print(url)
      -- 	vim.cmd("W3m " .. url)
      -- end, { desc = "[W]eb search URL from clipboard" })

      vim.keymap.set("n", "<leader>wd", function()
          -- local word = vim.fn.expand("<cword>")
          -- word = word:match("^ *(.-) *$")
          vim.cmd("normal! vE")
          vim.cmd('normal! "+y')
          local word = vim.fn.getreg("+")
          if word == "" then
              print("No word undor cursor to search")
              return
          end
          vim.fn.setreg("+", word)
          local url = "http://" .. word
          print(url)
          vim.cmd("W3m " .. url)
      end, { desc = "[W]eb [D]uckduckgo search URL" })

      vim.keymap.set("n", "<leader>wm", function()
          vim.cmd("call w3m#ShowURL()")
          local url = vim.v.statusmsg:match("w3m:%s*(.+)")
          vim.cmd("call w3m#ShowTitle()")
          local title = vim.v.statusmsg:match("w3m:%s*(.+)")
          if not url or url == "" then
              print("Failed to retrieve the URL")
              return
          end
          if not title or title == "" then
              print("Failed to retrieve the title")
              return
          end

          local bookmarks_file = vim.fn.expand("~/.local/state/nvim/w3m")
          vim.fn.mkdir(vim.fn.fnamemodify(bookmarks_file, ":h"), "p")

          local function bookmark_exists(i_url)
              local file = io.open(bookmarks_file, "r")
              if not file then
                  return false
              end
              for line in file:lines() do
                  -- if line:match("url:%s*" .. i_url) then
                  if line:match("url:%s*(.+)") == url then
                      file:close()
                      return true
                  end
              end
              file:close()
              return false
          end
          if bookmark_exists(url) then
              print("Bookmark already exists")
              return
          end

          local entry = string.format("- title: %s\nurl: %s\n", title, url)
          local file = io.open(bookmarks_file, "a")
          if file then
              file:write(entry)
              file:close()
              print("Bookmark saved: " .. title .. " (" .. url .. ")")
          else
              print("Failed to open bookmarks file.")
          end
      end, { desc = "Save [W]eb Book[M]ark" })
    '';

    # performance = {
    #   combinePlugins = {
    #     enable = true;
    #     standalonePlugins = [
    #       "hmts.nvim"
    #       "neorg"
    #       "nvim-treesitter"
    #     ];
    #   };
    #   byteCompileLua.enable = true;
    # };

    # viAlias = true;
    # vimAlias = true;

    # luaLoader.enable = true;

  };
}
