{ config, pkgs, ... }:

{
  # =========================
  # Git
  # =========================

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Aleksandr Kladov";
        email = "mail@kladov.xyz";
      };

      pull.rebase = true;
      init.defaultBranch = "master";
      core.editor = "nvim";
    };
  };
}
