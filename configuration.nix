{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];
  # Host and basic settings
  networking.hostName = "quantnix";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Moscow";
  # (Add any other basic settings like keymap or locale as needed)
 

  # Enable Hyprland Wayland compositor and required components
  programs.hyprland = {
    enable = true;               # Enable Hyprland compositor:contentReference[oaicite:10]{index=10}
    xwayland.enable = true;      # Enable XWayland support for X11 apps:contentReference[oaicite:11]{index=11}
    # (Using the default Hyprland package from nixpkgs; for development builds, one could override package & portalPackage)
  };
  
  boot.loader = {
    efi.canTouchEfiVariables = true;

    grub = {
      enable = true;
      efiSupport = true;
      devices = [ "nodev" ];  # UEFI загрузка без указания диска напрямую
    };
  };


  # NVIDIA driver configuration (proprietary 580.xx series)
  services.xserver.videoDrivers = [ "nvidia" ];  # Use NVIDIA driver (ensures kernel module and libs)
  hardware.graphics = {
    enable = true;
  };
  hardware.nvidia = {
    modesetting.enable = true;                         # Enable DRM KMS modesetting (required for Wayland):contentReference[oaicite:12]{index=12}:contentReference[oaicite:13]{index=13}
    package = config.boot.kernelPackages.nvidiaPackages.stable;  # Use the stable proprietary driver package (580.xx)
    # (For newer GPUs, NixOS may automatically use nvidia-open kernel module if needed)
    open = false;
  };

  # Enable greetd (console login manager) with tuigreet for Hyprland
  services.greetd.enable = true;
  services.greetd.settings = {
    default_session = {
      # Launch tuigreet and allow selection of X/Wayland sessions from NixOS session data
      command = "${pkgs.tuigreet}/bin/tuigreet --remember --remember-user-session --user-menu --user-menu-min-uid 1000 --asterisks --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions --xsessions ${config.services.displayManager.sessionData.desktops}/share/xsessions --power-shutdown 'shutdown -P now' --power-reboot 'shutdown -r now'";
      user = "greeter";
    };
    terminal = {
      vt = 1;  # use virtual console 1 for greetd
    };
  };
  # (No auto-login; user will be prompted by tuigreet to log in and then Hyprland starts)

  # Create user account for quantick
  users.users.quantick = {
    isNormalUser = true;
    home = "/home/quantick";
    description = "Hyprland User";
    extraGroups = [ "wheel" "video" "audio" "networkmanager" ];  # wheel for sudo, video for GPU, audio for sound, etc.
    shell = pkgs.zsh;  # or bash, as preferred
  };
  programs.zsh.enable = true;

  # Audio: PipeWire and WirePlumber (for sound and media controls)
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Fonts and cursors for theming
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono   # JetBrains Mono Nerd Font (monospace + icons)
    noto-fonts-color-emoji            # Emoji font for full emoji support
  ];
  console.font = "Lat2-Terminus16";  # console font (optional)
  # Cursor theme for Wayland (and X)
  environment.variables.XCURSOR_THEME = "Bibata-Modern-Ice";
  environment.variables.XCURSOR_SIZE = "24";

  # Environment variables for Wayland & NVIDIA (ensure apps use Wayland and NVIDIA GL)
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";                   # Hint Electron apps to use Wayland:contentReference[oaicite:14]{index=14}:contentReference[oaicite:15]{index=15}
    ELECTRON_OZONE_PLATFORM_HINT = "auto";  # Further force Electron apps to Wayland:contentReference[oaicite:16]{index=16}:contentReference[oaicite:17]{index=17}
    WLR_NO_HARDWARE_CURSORS = "1";          # Workaround for potential cursor rendering issues on NVIDIA:contentReference[oaicite:18]{index=18}
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";   # Use NVIDIA GLX (for X11 OpenGL):contentReference[oaicite:19]{index=19}:contentReference[oaicite:20]{index=20}
    LIBVA_DRIVER_NAME = "nvidia";           # Use NVIDIA VA-API driver (video acceleration):contentReference[oaicite:21]{index=21}:contentReference[oaicite:22]{index=22}
    GBM_BACKEND = "nvidia-drm";             # Use NVIDIA DRM backend for GBM
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    MOZ_ENABLE_WAYLAND = "1";
  };

  # System packages (additional)
  environment.systemPackages = with pkgs; [
    bibata-cursors
    # Utilities and core packages
    git vim less wget htop                                          # (examples of basic utilities)
    kitty                                                          # Kitty terminal (used in Hyprland keybinding)
    # Hyprland ecosystem
    hyprland    # (hyprland package includes hyprctl)
    hyprlock  hyprpaper  hypridle  # Hyprland tools (hyprpaper & hypridle not used initially, but included if needed)
    waybar    wofi       mako      # Bar, launcher, and notification daemon
    playerctl            # For media controls integration (Waybar)
    xdg-desktop-portal xdg-desktop-portal-hyprland  # Portals for screenshots, screencast, etc.
    # Login manager and polkit agent
    greetd     tuigreet                                     # Greetd service and TUI greeter for login:contentReference[oaicite:23]{index=23}:contentReference[oaicite:24]{index=24}
    hyprpolkitagent                                         # Polkit authentication agent for Hyprland:contentReference[oaicite:25]{index=25}

    firefox
  ];

  # (Optional: enable sudo for wheel group)
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;  # wheel users can sudo without password (set true if you prefer password)
  system.stateVersion = "26.05";
}

