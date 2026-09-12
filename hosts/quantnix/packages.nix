{ inputs, pkgs, ... }:

let
  system = pkgs.stdenv.hostPlatform.system;
  paseoDesktop =
    inputs.paseo.packages.${system}.desktop.overrideAttrs (old: {
      postInstall = (old.postInstall or "") + ''
        pty_dir="$out/share/paseo-desktop/packages/server/node_modules/node-pty/prebuilds"
        mkdir -p "$pty_dir"
        cp -a packages/server/node_modules/node-pty/prebuilds/linux-x64 "$pty_dir/"
        test -f "$pty_dir/linux-x64/pty.node"
      '';
    });
in
{
  # =========================
  # Packages
  # =========================

  environment.systemPackages = with pkgs; [
    git
    less
    ripgrep
    nerd-fonts.jetbrains-mono
    noto-fonts-color-emoji
    zsh-powerlevel10k
    wget
    htop
    btop
    ranger
    kitty
    firefox
    pavucontrol
    networkmanagerapplet
    jq
    nautilus
    geeqie
    gcalcli
    tmux
    google-chrome
    rustc
    cargo
    gcc
    bubblewrap
    ansible
    jdk21
    kubernetes-helm

    # AI Tools
    llm-agents.pi
    llm-agents.opencode
    llm-agents.claude-code
    paseoDesktop

    godot


    rpi-imager

    # Modern Unix
    ast-grep
    bat
    lsd
    delta
    dust
    duf
    fd
    cheat
    tldr
    gping
    procs
  ];

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
  };
}
