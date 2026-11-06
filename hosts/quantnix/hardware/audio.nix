# ==========================================================
# Звук — PipeWire (заменяет PulseAudio/ALSA/JACK)
# ==========================================================
{ pkgs, ... }:

{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true; # Steam/Wine и прочие 32-бит приложения
    pulse.enable = true; # совместимость с PulseAudio-клиентами
  };

  environment.systemPackages = with pkgs; [
    pavucontrol # GUI микшер
    playerctl # play/pause/next для MPRIS-плееров
  ];
}
