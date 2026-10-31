# ==========================================================
# direnv — автозагрузка окружения при `cd` в проект
# ==========================================================
{ ... }:

{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true; # кэширует `use flake` / `use nix`
  };
}
