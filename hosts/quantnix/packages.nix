# ==========================================================
# Системные пакеты — доступны всем пользователям
#
# Пакеты конкретных подсистем живут в своих модулях
# (audio, hyprland, fonts). Личные приложения —
# в home/quantick/packages.nix
# ==========================================================
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- База ---
    git
    less
    wget
    jq
    tmux
    ranger
    htop
    btop
    bubblewrap
    wireguard-tools

    # --- Modern Unix (замены классике) ---
    ripgrep # grep
    fd # find
    bat # cat
    lsd # ls
    delta # diff (для git)
    dust # du
    duf # df
    procs # ps
    gping # ping
    ast-grep # структурный поиск по коду
    cheat
    tldr

    # --- Графика / GUI ---
    firefox
    google-chrome
    nautilus
    geeqie

    # --- Разработка ---
    gcc
    rustc
    cargo
    jdk21
    ansible
    kubernetes-helm

    # --- AI ---
    llm-agents.opencode

    # --- Прочее ---
    gcalcli
    zoom-us
    blender
    rpi-imager
  ];
}
