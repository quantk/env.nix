# ==========================================================
# Plymouth — заставка при загрузке и выключении
#
# Свои темы: envix-ripple, envix-orbit, envix-helix,
#            envix-comet, envix-pulse (см. scripts/)
# Посмотреть любую тему без перезагрузки: plymouth-preview
# ==========================================================
{ config, pkgs, ... }:

let
  envixThemes = pkgs.callPackage ./themes.nix { };

  preview = pkgs.writeShellApplication {
    name = "plymouth-preview";
    runtimeInputs = [ config.boot.plymouth.package pkgs.util-linux pkgs.jq pkgs.procps ];
    runtimeEnv.ENVIX_THEMES = "${envixThemes}/share/plymouth/themes";
    text = builtins.readFile ./preview.sh;
  };
in
{
  boot.plymouth = {
    enable = true;
    themePackages = [ pkgs.adi1090x-plymouth-themes envixThemes ];
    theme = "envix-ripple";
  };

  environment.systemPackages = [ preview ];
}
