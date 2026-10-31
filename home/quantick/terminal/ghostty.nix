# ==========================================================
# Ghostty — терминал (SUPER+Enter)
# Все опции: ghostty +show-config --default --docs
# ==========================================================
{ ... }:

{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true; # shell integration: cwd, промпт-метки, заголовки

    settings = {
      font-size = 18;
      background-opacity = 0.7;
      confirm-close-surface = false; # закрывать без вопроса
      # Скорость скролла: discrete — колесо мыши (дефолт 3), precision — тачпад (дефолт 1)
      mouse-scroll-multiplier = "precision:0.5,discrete:1";
    };
  };
}
