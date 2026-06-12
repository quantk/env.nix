{ pkgs, ... }:

let
  kickstartNvim = pkgs.fetchFromGitHub {
    owner = "nvim-lua";
    repo = "kickstart.nvim";
    # Last lazy.nvim-based revision before kickstart moved to vim.pack from Neovim 0.12.
    rev = "cd7adee3cebd9cc915bbe69db5472b7da479e001";
    hash = "sha256-5dD1KAjYsN4dGrc3XHWb8CjF/wmg8ll2efrqQS8DOAI=";
  };

  nvimConfig = pkgs.runCommand "nvim-config" { } ''
    mkdir -p $out
    cp -R ${kickstartNvim}/. $out/
    chmod -R u+w $out

    substituteInPlace $out/init.lua \
      --replace-fail "-- { import = 'custom.plugins' }," "{ import = 'custom.plugins' },"

    install -Dm0644 ${./after/plugin/golang.lua} $out/after/plugin/golang.lua
    install -Dm0644 ${./after/plugin/lsp-keymaps.lua} $out/after/plugin/lsp-keymaps.lua
    install -Dm0644 ${./lua/custom/plugins/render-markdown.lua} $out/lua/custom/plugins/render-markdown.lua
  '';
in

{
  # =========================
  # Nvim config
  # =========================

  xdg.configFile."nvim".source = nvimConfig;
}
