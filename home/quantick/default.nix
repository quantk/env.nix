{ ... }:

{
  imports = [
    ./apps.nix
    ./git.nix
    ./shell.nix
    ./vscode.nix
    ./flameshot.nix
    ./direnv.nix

    ./hypr/default.nix
    ./waybar/default.nix
    ./wlogout/default.nix
    ./kitty/default.nix
    ./nvim/default.nix
    ./mako/default.nix
    ./wofi/default.nix
  ];

  home.username = "quantick";
  home.homeDirectory = "/home/quantick";
  home.stateVersion = "26.05";

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];
      "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
      "x-scheme-handler/tonsite" = [ "org.telegram.desktop.desktop" ];
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  xdg.enable = true;
}
