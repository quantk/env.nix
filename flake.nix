# ╔══════════════════════════════════════════════════════════╗
# ║  envix — NixOS + Home Manager окружение                  ║
# ║                                                          ║
# ║  hosts/quantnix/   система (ядро, железо, сервисы, DE)   ║
# ║  home/quantick/    пользователь (приложения, конфиги)    ║
# ║                                                          ║
# ║  Применить:  sudo nixos-rebuild switch --flake .#quantnix║
# ╚══════════════════════════════════════════════════════════╝
{
  description = "envix — Hyprland on NixOS (host: quantnix)";

  # ==========================================================
  # Inputs — откуда берутся пакеты и модули
  # ==========================================================
  inputs = {
    # Основная пакетная база (rolling release)
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Декларативный $HOME: ~/.config, пользовательские пакеты
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Расширения VS Code → pkgs.vscode-marketplace.*
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    # AI-агенты (opencode и др.) → pkgs.llm-agents.*
    llm-agents.url = "github:numtide/llm-agents.nix";

    # Codex Desktop для Linux (HM-модуль, включается в home/quantick/packages.nix)
    codex-desktop-linux.url = "github:ilysenko/codex-desktop-linux";
  };

  # ==========================================================
  # Outputs — что флейк собирает
  # ==========================================================
  outputs = { nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.quantnix = nixpkgs.lib.nixosSystem {
      # `inputs` доступен в любом модуле как аргумент
      specialArgs = { inherit inputs; };

      modules = [
        # --- Система ---
        ./hosts/quantnix/default.nix

        # --- Пользователь (Home Manager как модуль NixOS) ---
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true; # тот же pkgs (с оверлеями и unfree), что у системы
            useUserPackages = true; # home.packages ставятся в /etc/profiles/per-user
            sharedModules = [
              inputs.codex-desktop-linux.homeManagerModules.default
            ];
            users.quantick = import ./home/quantick/default.nix;
          };
        }
      ];
    };
  };
}
