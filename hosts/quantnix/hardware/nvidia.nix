# ==========================================================
# NVIDIA — проприетарный драйвер под Wayland
# ==========================================================
{ config, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true; # обязательно для Wayland (nvidia-drm.modeset=1)
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    open = false; # закрытые модули ядра (не open-gpu-kernel-modules)
  };

  # Драйвер USB-C контроллера на картах NVIDIA (Cypress CCGx).
  # Сыплет ошибками в dmesg и тормозит загрузку — отключаем.
  boot.blacklistedKernelModules = [ "ucsi_ccg" ];

  # Подсказки GL/VA-API/GBM, что рендерим через NVIDIA
  environment.sessionVariables = {
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
  };
}
