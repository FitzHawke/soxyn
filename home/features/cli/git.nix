{ pkgs, lib, config, ... }: {
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    aliases = {
      pushall = "!git remote | xargs -L1 git push --all";
      graph = "log --decorate --oneline --graph";
    };
    userName = config.sops.secrets.user1-git-name;
    userEmail = config.sops.secrets.user1-git-email;
    extraConfig = {
      feature.manyFiles = true;
      init.defaultBranch = "main";
      user.signing.key = config.sops.secrets.user1-git-key;
      commit.gpgSign = true;
      gpg.program = "${config.programs.gpg.package}/bin/gpg2";
    };
    lfs.enable = true;
    ignores = [ ".direnv" "result" ];
  };

  sops.secrets = {
    sopsFile = ../../../users/secrets.yaml;
    user1-git-name = { };
    user1-git-email = { };
    user1-git-key = { };
  };
}
