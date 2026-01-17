{ config, pkgs, ... }:

{
  # =========================
  # Hyprland
  # =========================

  programs.hyprland = {
    enable = true; 
    xwayland.enable = true;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono 
    noto-fonts-color-emoji
  ];
  console.font = "Lat2-Terminus16"; 
  environment.variables.XCURSOR_THEME = "Bibata-Modern-Ice";
  environment.variables.XCURSOR_SIZE = "24";

  environment.sessionVariables = {
    ELECTRON_OZONE_PLATFORM_HINT = "auto"; 
    WLR_NO_HARDWARE_CURSORS = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_CURRENT_DESKTOP = "Hyprland";
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --remember --remember-user-session --user-menu --user-menu-min-uid 1000 --asterisks --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions --xsessions ${config.services.displayManager.sessionData.desktops}/share/xsessions --power-shutdown 'shutdown -P now' --power-reboot 'shutdown -r now'";
        user = "greeter";
      };
      terminal = {
        vt = 1; 
      };
    };
  };

  environment.systemPackages = with pkgs; [
    bibata-cursors
    hyprland
    hyprlock
    hyprpaper
    waybar
    wofi
    mako
    playerctl
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
    greetd tuigreet
    hyprpolkitagent
  ];
}

