{ pkgs, ... }:

{
  # =========================
  # Bootloader (UEFI + GRUB)
  # =========================
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };

    grub = {
      enable = true;
      efiSupport = true;
      devices = [ "nodev" ];
    };
  };

  # =========================
  # Kernel
  # =========================
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "quiet"
    "splash"
    "loglevel=3"
    "rd.systemd.show_status=auto"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
  ];
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  console.earlySetup = true;
  boot.blacklistedKernelModules = [ "ucsi_ccg" ];

  # =========================
  # Plymouth
  # =========================
  boot.plymouth = {
    enable = true;
    themePackages = [ pkgs.adi1090x-plymouth-themes ];
    theme = "owl";
  };

  # =========================
  # Filesystems / tmp
  # =========================
  boot.tmp.cleanOnBoot = true;

  # =========================
  # Initrd
  # =========================
  boot.initrd.systemd.enable = true;

  # =========================
  # sysctl (редко, но бывает)
  # =========================
  boot.kernel.sysctl = {
    "kernel.sysrq" = 1;
  };
}
