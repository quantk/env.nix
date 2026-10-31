# ==========================================================
# Шрифты и курсор
# ==========================================================
{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono # моноширинный + иконки (waybar, nvim)
    noto-fonts-color-emoji
  ];

  # --- Курсор ---
  environment.systemPackages = [ pkgs.bibata-cursors ];
  environment.variables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };
}
