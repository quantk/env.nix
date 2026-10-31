# ==========================================================
# Печать — CUPS + автопоиск сетевых принтеров
# ==========================================================
{ ... }:

{
  services.printing = {
    enable = true;
    # drivers = [ pkgs.gutenprint ]; # если принтеру нужен драйвер
  };

  # mDNS/Bonjour: находит принтеры (и *.local хосты) в LAN
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
