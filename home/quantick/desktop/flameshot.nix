# ==========================================================
# Flameshot — скриншоты (Print)
# ==========================================================
{ ... }:

{
  # Flameshot v14 под Wayland снимает экран через xdg-desktop-portal
  # (ключ useGrimAdapter удалён и вызывает ошибку конфига)
  xdg.configFile."flameshot/flameshot.ini".text = ''
    [General]
    disabledTrayIcon=true
    showStartupLaunchMessage=false
  '';
}
