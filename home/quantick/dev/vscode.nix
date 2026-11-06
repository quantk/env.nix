# ==========================================================
# VS Code — расширения и настройки
# ==========================================================
{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    profiles.default = {
      # Из оверлея nix-vscode-extensions (hosts/quantnix/system/nix.nix)
      extensions = with pkgs.vscode-marketplace; [
        jnoortheen.nix-ide
        vscodevim.vim
      ];

      userSettings = {
        "editor.fontSize" = 18;

        # --- Nix: LSP + форматирование при сохранении ---
        "nix.enableLanguageServer" = true;
        "nix.formatterPath" = "nixpkgs-fmt";
        "[nix]" = {
          "editor.defaultFormatter" = "jnoortheen.nix-ide";
          "editor.formatOnSave" = true;
        };
      };
    };
  };
}
