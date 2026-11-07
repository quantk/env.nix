# ==========================================================
# Тема приложений — GTK тёмная, иконки Papirus, шрифт Inter
# Чтобы Nautilus/pavucontrol/диалоги не выбивались из палитры
# ==========================================================
{ pkgs, ... }:

{
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice"; # пакет — hosts/quantnix/desktop/fonts.nix
      size = 24;
    };
    font = {
      name = "Inter";
      size = 11;
    };
  };

  # libadwaita (GTK4) и порталы берут тёмную схему отсюда
  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
}
