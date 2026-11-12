# ==========================================================
# Steam — игры и ассеты Wallpaper Engine (appid 431960)
#
# Wallpaper Engine ставится через Proton только ради ассетов
# и Workshop; рендерит обои linux-wallpaperengine (hyprland.nix)
# ==========================================================
{ ... }:

{
  # Ставит Steam, включает 32-битную графику (hardware.graphics.enable32Bit)
  # и udev-правила для геймпадов
  programs.steam.enable = true;
}
