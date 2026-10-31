# ==========================================================
# Nix / nixpkgs — настройки самого пакетного менеджера
# ==========================================================
{ inputs, pkgs, ... }:

{
  # --- Демон nix ---
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Дедупликация store: одинаковые файлы — хардлинки
  nix.settings.auto-optimise-store = true;

  # --- Автоочистка ---
  # nix.gc чистит только по возрасту; nh умеет оставлять N последних генераций
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep 3";
    };
  };

  # --- nixpkgs ---
  nixpkgs.config.allowUnfree = true; # nvidia, vscode, chrome, spotify, …

  # Оверлеи: подмешивают в pkgs пакеты из сторонних флейков
  nixpkgs.overlays = [
    inputs.nix-vscode-extensions.overlays.default # pkgs.vscode-marketplace.*
    inputs.llm-agents.overlays.shared-nixpkgs # pkgs.llm-agents.*
  ];

  # --- nix-ld ---
  # Запуск чужих динамических бинарников (npm/pip-колёса, IDE-плагины)
  # без patchelf: подкладывает загрузчик и базовые .so
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
      openssl
    ];
  };

  # Пример: зеркало npm, если основной реестр недоступен
  # environment.variables.NPM_CONFIG_REGISTRY = "https://registry.npmmirror.com";
}
