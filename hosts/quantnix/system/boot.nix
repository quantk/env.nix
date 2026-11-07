# ==========================================================
# Загрузка — GRUB (UEFI), ядро, тихий boot
# Сама заставка Plymouth — в ./plymouth/
# ==========================================================
{ pkgs, ... }:

{
  # --- Загрузчик ---
  boot.loader = {
    efi.canTouchEfiVariables = true;

    grub = {
      enable = true;
      efiSupport = true;
      devices = [ "nodev" ]; # UEFI: в MBR не пишем
      configurationLimit = 3; # в меню только 3 последние генерации
    };
  };

  # --- Ядро ---
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Тихая загрузка: минимум логов, сразу splash
  boot.kernelParams = [
    "quiet"
    "splash"
    "loglevel=3"
    "rd.systemd.show_status=auto"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
  ];
  boot.consoleLogLevel = 0;

  # Magic SysRq: аварийные комбинации Alt+PrtSc+<key>
  boot.kernel.sysctl."kernel.sysrq" = 1;

  # --- initrd ---
  boot.initrd.systemd.enable = true; # нужен для гладкого Plymouth
  boot.initrd.verbose = false;

  # --- Консоль (TTY) ---
  console.earlySetup = true; # шрифт применяется уже в initrd
  console.font = "Lat2-Terminus16";

  # --- /tmp ---
  boot.tmp.cleanOnBoot = true;
}
