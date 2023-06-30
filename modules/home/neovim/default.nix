{
  inputs,
  pkgs,
  ...
}: let
  neovim = inputs.neovim-flake;
in {
  imports = [
    neovim.homeManagerModules.default
  ];

  home.sessionVariables.EDITOR = "nvim";
  programs.neovim-flake = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;
        startPlugins = with pkgs; [vimPlugins.nvim-surround];
        luaConfigRC.test = neovim.lib.nvim.dag.entryAnywhere ''
          require("nvim-surround").setup({})
        '';
        enableEditorconfig = true;
        debugMode = {
          enable = false;
          level = 20;
          logFile = "/tmp/nvim.log";
        };
      };

      vim.lsp = {
        formatOnSave = true;
        lspkind.enable = false;
        lightbulb.enable = true;
        lspsaga.enable = false;
        nvimCodeActionMenu.enable = true;
        trouble.enable = true;
        lspSignature.enable = true;
      };

      vim.languages = {
        enableLSP = true;
        enableFormat = true;
        enableTreesitter = true;
        enableExtraDiagnostics = true;

        nix.enable = true;
        html.enable = true;
        clang.enable = false;
        sql.enable = false;
        ts.enable = true;
        go.enable = false;
        zig.enable = false;
        python.enable = true;
        dart.enable = false;
        elixir.enable = false;
        svelte.enable = false;
        rust = {
          enable = false;
          crates.enable = false;
        };
      };

      vim.visuals = {
        enable = true;
        nvimWebDevicons.enable = true;
        scrollBar.enable = true;
        smoothScroll.enable = true;
        cellularAutomaton.enable = true;
        fidget-nvim.enable = true;
        indentBlankline = {
          enable = true;
          fillChar = null;
          eolChar = null;
          showCurrContext = true;
        };
        cursorWordline = {
          enable = true;
          lineTimeout = 0;
        };
      };

      vim.statusline = {
        lualine = {
          enable = true;
          theme = "catppuccin";
        };
      };

      vim.theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha";
        transparent = true;
      };
      vim.autopairs.enable = true;

      vim.autocomplete = {
        enable = true;
        type = "nvim-cmp";
      };

      vim.filetree = {
        nvimTreeLua = {
          enable = true;

          renderer = {
            rootFolderLabel = null;
          };

          view = {
            width = 25;
          };

          mappings = {
            toggle = "<C-W>";
          };
        };
      };

      vim.tabline = {
        nvimBufferline.enable = true;
      };

      vim.treesitter.context.enable = true;

      vim.binds = {
        whichKey.enable = true;
        cheatsheet.enable = true;
      };

      vim.telescope.enable = true;

      vim.git = {
        enable = true;
        gitsigns.enable = true;
        gitsigns.codeActions = false;
      };

      vim.minimap = {
        minimap-vim.enable = false;
        codewindow.enable = true; # lighter, faster, and uses lua for configuration
      };

      vim.dashboard = {
        dashboard-nvim.enable = false;
        alpha.enable = true;
      };

      vim.notify = {
        nvim-notify.enable = true;
      };

      vim.projects = {
        project-nvim.enable = true;
      };

      vim.utility = {
        ccc.enable = true;
        icon-picker.enable = true;
        diffview-nvim.enable = true;
        vim-wakatime.enable = false;
        motion = {
          hop.enable = true;
          leap.enable = false;
        };
      };

      vim.notes = {
        mind-nvim.enable = true;
        todo-comments.enable = true;
      };

      vim.terminal = {
        toggleterm.enable = true;
      };

      vim.ui = {
        noice.enable = true;
        colorizer.enable = true;
        modes-nvim.enable = false;
        smartcolumn = {
          enable = true;
          columnAt.languages = {
            nix = 150;
            ruby = 110;
            java = 120;
            go = [110 150];
          };
        };
      };

      vim.assistant = {
        copilot.enable = false;
      };

      vim.session = {
        nvim-session-manager.enable = true;
      };

      vim.gestures = {
        gesture-nvim.enable = false;
      };

      vim.comments = {
        comment-nvim.enable = true;
      };

      vim.presence.presence-nvim.enable = false;
    };
  };
}
