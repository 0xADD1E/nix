{ ... }: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    difftastic.enable = true;

    userEmail = "developer@0xADD1E.me";
    userName = "Karolina Liskova";
    includes = [
      {
        # Prompt
        condition = "gitdir:~/Documents/Prompt/";
        contents = {
          core.sshCommand = "ssh -i ~/.ssh/prompt_id_ed25519";
          user.email = "kaja@weareprompt.com";
        };
      }
      {
        # Xoala
        condition = "gitdir:~/Documents/Xoala/";
        contents = {
          core.sshCommand = "ssh -i ~/.ssh/xoala_id_ed25519";
          user.email = "karolina.liskova@xoala.com";
        };
      }
      {
        # Alchemy
        condition = "gitdir:~/Documents/Alchemy/";
        contents = {
          core.sshCommand = "ssh -i ~/.ssh/alchemy_id_ed25519";
          user.email = "kaja.liskova@alchemymarkets.com";
        };
      }
    ];
    extraConfig = {
      fetch.parallel = 0;
      pull.rebase = true;
      push.default = "current";
      init.defaultBranch = "main";
      merge.ff = "only";
    };

    ignores = [
      ".DS_Store"
      ".prettier_d"
      ".idea"
      ".vscode"
      ".direnv"
    ];
    aliases = {
      lg = "log --pretty=oneline --graph --abbrev-commit --all";
      cln = "clean --exclude='*.env' --exclude='.env' -dx";
      fetchall = "fetch --all --tags --prune --prune-tags";
    };
  };
  programs.git-credential-oauth.enable = true;
}
