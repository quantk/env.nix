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
