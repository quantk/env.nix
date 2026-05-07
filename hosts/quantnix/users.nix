{ pkgs, ... }:

{
  # =========================
  # Users
  # =========================

  users.users.quantick = {
    isNormalUser = true;
    home = "/home/quantick";
    description = "quantick";
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "networkmanager"
      "docker"
      "podman"
      "dialout"
      "tty"
    ];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;
}
