{ pkgs, lib, config, ... }: {
  home.packages = [ git-m7 ];
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    aliases = {
      pushall = "!git remote | xargs -L1 git push --all";
      graph = "log --decorate --oneline --graph";
      add-nowhitespace = "!git diff -U0 -w --no-color | git apply --cached --ignore-whitespace --unidiff-zero -";
    };
    userName = "Gabriel Fontes";
    userEmail = "hi@m7.rs";
    extraConfig = {
      feature.manyFiles = true;
      init.defaultBranch = "main";
      user.signing.key = "CE707A2C17FAAC97907FF8EF2E54EA7BFE630916";
      commit.gpgSign = true;
      gpg.program = "${config.programs.gpg.package}/bin/gpg2";
    };
    lfs.enable = true;
    ignores = [ ".direnv" "result" ];
  };
}
