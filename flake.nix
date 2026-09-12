{
  description = "Hyprland on NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    llm-agents.url = "github:numtide/llm-agents.nix";
    paseo = {
      url = "github:getpaseo/paseo";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    codex-desktop-linux.url = "github:ilysenko/codex-desktop-linux";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nixpkgs-godot.url = "github:NixOS/nixpkgs/nixos-unstable";
    herdr = {
      url = "github:ogulcancelik/herdr/v0.7.5";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-godot
    , home-manager
    , llm-agents
    , ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations.quantnix = nixpkgs.lib.nixosSystem {
        inherit system;
        pkgs = pkgs;
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./hosts/quantnix/default.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [
              inputs.codex-desktop-linux.homeManagerModules.default
            ];
            home-manager.users.quantick = import ./home/quantick/default.nix;
          }

          {
            nixpkgs.overlays = [
              llm-agents.overlays.shared-nixpkgs
              (final: prev: {
                godot = (import nixpkgs-godot { inherit system; }).godot_4;
                herdr = inputs.herdr.packages.${system}.default;
              })
            ];
          }
        ];
      };
    };
}
