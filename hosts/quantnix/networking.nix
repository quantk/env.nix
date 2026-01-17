{ config, pkgs, ... }:

{
  # =========================
  # Network
  # =========================

  networking.hostName = "quantnix";
  networking.networkmanager.enable = true;
}

