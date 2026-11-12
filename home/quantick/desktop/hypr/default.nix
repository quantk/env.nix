# ==========================================================
# Hypr* — конфиги Hyprland и его утилит
# ==========================================================
{ ... }:

{
  xdg.configFile = {
    "hypr/hyprland.conf".source = ./hyprland.conf; # биндинги, автозапуск, вид
    "hypr/hyprpaper.conf".source = ./hyprpaper.conf; # обои
    "hypr/wallpaper.sh".source = ./wallpaper.sh; # живые обои (Wallpaper Engine)
    "hypr/hyprlock.conf".source = ./hyprlock.conf; # экран блокировки
    "hypr/hyprsunset.conf".source = ./hyprsunset.conf; # ночной режим
  };
}
