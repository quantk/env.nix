{ pkgs, ... }:

{
  # =========================
  # Visual Studio Code (+ plugins)
  # =========================

  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    profiles.default = {
      extensions = [
        pkgs.vscode-marketplace.jnoortheen.nix-ide
        pkgs.vscode-marketplace.vscodevim.vim
      ];

      userSettings = {
        "nix.enableLanguageServer" = true;
        "nix.formatterPath" = "nixpkgs-fmt";
        "[nix]" = {
          "editor.defaultFormatter" = "jnoortheen.nix-ide";
          "editor.formatOnSave" = true;
        };
        "files.associations" = {
          "*.nix" = "nix";
        };

        "editor.fontSize" = 18;
      };
    };
  };
}
