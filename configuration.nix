{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];
  networking.hostName = "quantnix";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Moscow";
 
  programs.hyprland = {
    enable = true; 
    xwayland.enable = true;
  };
  
  boot.loader = {
    efi.canTouchEfiVariables = true;

    grub = {
      enable = true;
      efiSupport = true;
      devices = [ "nodev" ];
    };
  };


  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics = {
    enable = true;
  };
  hardware.nvidia = {
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    open = false;
  };

  services.greetd.enable = true;
  services.greetd.settings = {
    default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --remember --remember-user-session --user-menu --user-menu-min-uid 1000 --asterisks --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions --xsessions ${config.services.displayManager.sessionData.desktops}/share/xsessions --power-shutdown 'shutdown -P now' --power-reboot 'shutdown -r now'";
      user = "greeter";
    };
    terminal = {
      vt = 1; 
    };
  };

  users.users.quantick = {
    isNormalUser = true;
    home = "/home/quantick";
    description = "Hyprland User";
    extraGroups = [ "wheel" "video" "audio" "networkmanager" ]; 
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono 
    noto-fonts-color-emoji
  ];
  console.font = "Lat2-Terminus16"; 
  environment.variables.XCURSOR_THEME = "Bibata-Modern-Ice";
  environment.variables.XCURSOR_SIZE = "24";

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; 
    ELECTRON_OZONE_PLATFORM_HINT = "auto"; 
    WLR_NO_HARDWARE_CURSORS = "1";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm"; 
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    MOZ_ENABLE_WAYLAND = "1";
  };

  environment.systemPackages = with pkgs; [
    bibata-cursors
    git vim less wget htop btop
    kitty 
    hyprland 
    hyprlock  hyprpaper
    waybar    wofi       mako    
    playerctl    xdg-desktop-portal xdg-desktop-portal-hyprland  
    greetd     tuigreet 
    hyprpolkitagent 

    firefox
  ];

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;
  system.stateVersion = "26.05";
}

