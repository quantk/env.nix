# ==========================================================
# Waybar — верхняя панель
# ==========================================================
{ ... }:

{
  xdg.configFile = {
    "waybar/config.jsonc".source = ./config.jsonc; # модули панели
    "waybar/style.css".source = ./style.css; # оформление

    # Кастомные модули (погода wttr.sh и т.п.)
    "waybar/scripts" = {
      source = ./scripts;
      recursive = true;
    };
  };
}
