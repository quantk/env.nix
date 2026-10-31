# ==========================================================
# Пользователи и права
# ==========================================================
{ pkgs, ... }:

{
  users.users.quantick = {
    isNormalUser = true;
    home = "/home/quantick";
    description = "quantick";
    shell = pkgs.zsh;

    extraGroups = [
      "wheel" # sudo
      "video" # GPU, подсветка
      "audio"
      "networkmanager" # управление сетью без root
      "docker" # docker без sudo (≈ root!)
      "dialout" # serial: Arduino, ESP, USB-UART
      "tty"
    ];
    # группа k3s добавляется в services/k3s.nix
  };

  # zsh должен быть включён системно, чтобы стать login shell.
  # Сам конфиг zsh — в home/quantick/terminal/zsh.nix
  programs.zsh.enable = true;

  # --- sudo ---
  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
  };
}
