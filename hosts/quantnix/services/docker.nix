# ==========================================================
# Docker
# ==========================================================
{ pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    package = pkgs.docker_25; # запинена версия
  };
  # доступ без sudo — через группу docker в system/users.nix
}
