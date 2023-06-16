{
  pkgs,
  lib,
  config,
  ...
}: let
  apply-hm-env = pkgs.writeShellScript "apply-hm-env" ''
    ${lib.optionalString (config.home.sessionPath != []) ''
      export PATH=${builtins.concatStringsSep ":" config.home.sessionPath}:$PATH
    ''}
    ${builtins.concatStringsSep "\n" (lib.mapAttrsToList (k: v: ''
        export ${k}=${v}
      '')
      config.home.sessionVariables)}
    ${config.home.sessionVariablesExtra}
    exec "$@"
  '';

  # runs processes as systemd transient services
  run-as-service = pkgs.writeShellScriptBin "run-as-service" ''
    exec ${pkgs.systemd}/bin/systemd-run \
      --slice=app-manual.slice \
      --property=ExitType=cgroup \
      --user \
      --wait \
      bash -lc "exec ${apply-hm-env} $@"
  '';
in {
  home.packages = with pkgs; [run-as-service comma ripgrep];
  home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";

  programs = {
    nix-index.enable = false;
    exa.enable = true;
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    dircolors = {
      enable = true;
      enableFishIntegration = true;
    };

    skim = {
      enable = true;
      enableFishIntegration = true;
      defaultCommand = "rg --files --hidden";
      changeDirWidgetOptions = [
        "--preview 'exa --icons --git --color always -T -L 3 {} | head -200'"
        "--exact"
      ];
    };

    starship = {
      enable = true;
      settings = {
        add_newline = false;
        scan_timeout = 5;
        character = {
          error_symbol = "[󰊠](bold red)";
          success_symbol = "[󰊠](bold green)";
          vicmd_symbol = "[󰊠](bold yellow)";
          format = "$symbol [|](bold bright-black) ";
        };
        git_commit = {commit_hash_length = 4;};
        line_break.disabled = false;
        lua.symbol = "[](blue) ";
        python.symbol = "[](blue) ";
        hostname = {
          ssh_only = true;
          format = "[$hostname](bold blue) ";
          disabled = false;
        };
      };
    };

    fish = {
      enable = true;
      shellAbbrs = with pkgs;
      with lib; {
        jqless = "jq -C | less -r";

        vim = "${getExe neovim}";
        vi = "${getExe neovim}";

        cik = "clone-in-kitty --type os-window";

        cat = "${getExe bat} --style=plain";
        grep = getExe ripgrep;
        fzf = getExe skim;
        MANPAGER = "sh -c 'col -bx | bat -l man -p'";
        du = getExe du-dust;
        ps = getExe procs;
        m = "mkdir -p";
        fcd = "cd $(find -type d | fzf)";
        l = "ls -lF --time-style=long-iso --icons";
        sc = "doas systemctl";
        scu = "systemctl --user ";
        la = "${getExe exa} -lah --tree";
        ls = "${getExe exa} -h --git --icons --color=auto --group-directories-first -s extension";
        tree = "${getExe exa} --tree --icons --tree";
        burn = "pkill -9";
        diff = "diff --color=auto";
        ".." = "cd ..";
        "..." = "cd ../../";
        "...." = "cd ../../../";
        "....." = "cd ../../../../";
        "......" = "cd ../../../../../";

        docs = "$HOME/documents";
        notes = "$HOME/documents/notes";
        dotfiles = "$HOME/workspaces/dotfiles";
        dl = "$HOME/download";
        vids = "$HOME/videos";
        music = "$HOME/music";
        work = "$HOME/workspaces";
        media = "/run/media/$USER";
      };
      shellAliases = with pkgs;
      with lib; {
        # Clear screen and scrollback
        clear = "printf '\\033[2J\\033[3J\\033[1;1H'";
        rebuild = "doas nix-store --verify; pushd ~/dev/dotfiles && doas nixos-rebuild switch --flake .# && notify-send \"Done\"&& bat cache --build; popd";
        cleanup = "doas nix-collect-garbage --delete-older-than 7d";
        bloat = "nix path-info -Sh /run/current-system";
        ytmp3 = ''
          ${lib.getExe yt-dlp} -x --continue --add-metadata --embed-thumbnail --audio-format mp3 --audio-quality 0 --metadata-from-title = "%(artist)s - %(title)s" - -prefer-ffmpeg - o "%(title)s.%(ext)s" '';
      };
      functions = {
        # Disable greeting
        fish_greeting = "";
        # Grep using ripgrep and pass to nvim
        nvimrg = "nvim -q (rg --vimgrep $argv | psub)";
      };
      interactiveShellInit = ''
        fish_vi_key_bindings
        set fish_cursor_default     block      blink
        set fish_cursor_insert      line       blink
        set fish_cursor_replace_one underscore blink
        set fish_cursor_visual      block
      '';
    };
  };
}
