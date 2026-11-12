# ==========================================================
# Хост quantnix — точка входа системной конфигурации
#
# system/    загрузка, nix, пользователи, сеть
# hardware/  GPU, звук, принтеры
# desktop/   Hyprland, логин-менеджер, шрифты
# services/  контейнеры и кластер
# ==========================================================
{ ... }:

{
  imports = [
    # Сгенерировано nixos-generate-config — руками не трогать
    ./hardware-configuration.nix

    # --- Система ---
    ./system/boot.nix
    ./system/plymouth
    ./system/nix.nix
    ./system/users.nix
    ./system/networking.nix

    # --- Железо ---
    ./hardware/nvidia.nix
    ./hardware/audio.nix
    ./hardware/print.nix

    # --- Рабочий стол ---
    ./desktop/hyprland.nix
    ./desktop/greetd.nix
    ./desktop/fonts.nix
    ./desktop/steam.nix

    # --- Сервисы ---
    ./services/docker.nix
    ./services/k3s.nix

    # --- Системные пакеты ---
    ./packages.nix
  ];

  time.timeZone = "Europe/Moscow";

  # Версия NixOS, с которой система установлена.
  # НЕ менять при обновлениях — влияет на миграции stateful-данных.
  system.stateVersion = "26.05";
}
