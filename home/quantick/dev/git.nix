# ==========================================================
# Git
# ==========================================================
{ ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Aleksandr Kladov";
        email = "mail@kladov.xyz";
      };

      pull.rebase = true; # pull = fetch + rebase, без merge-коммитов
      init.defaultBranch = "master";
      core.editor = "nvim";
    };
  };
}
