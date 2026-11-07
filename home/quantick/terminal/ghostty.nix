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
      font-family = "JetBrainsMono Nerd Font";
      background-opacity = 0.78; # Hyprland размывает фон под окном
      window-padding-x = 14;
      window-padding-y = 10;
      window-padding-balance = true;
      cursor-style = "bar";

      # --- Палитра «Twilight» (как у Hyprland/waybar) ---
      background = "0f0e1a";
      foreground = "e6e3f5";
      cursor-color = "b4a7ff";
      selection-background = "34305a";
      selection-foreground = "e6e3f5";
      palette = [
        "0=#26233d"
        "1=#ff7a93"
        "2=#a6e3c4"
        "3=#ffc79a"
        "4=#8aa4ff"
        "5=#b4a7ff"
        "6=#8fd8f0"
        "7=#c9c5e3"
        "8=#4a4670"
        "9=#ff99ad"
        "10=#bdeed4"
        "11=#ffd7b5"
        "12=#a8bcff"
        "13=#f5a3d7"
        "14=#ade6f7"
        "15=#e6e3f5"
      ];
      confirm-close-surface = false; # закрывать без вопроса
      # Скорость скролла: discrete — колесо мыши (дефолт 3), precision — тачпад
      # и hi-res колёса под Wayland (дефолт 1)
      mouse-scroll-multiplier = "precision:0.2,discrete:1";
    };
  };
}
