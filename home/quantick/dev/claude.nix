# ==========================================================
# Claude Code — ~/.claude/settings.json
#
# Файл не симлинк: Claude Code сам пишет в него (/config,
# плагины, разрешения). При активации HM объявленные здесь
# ключи вливаются в существующий файл (jq `*`): наши значения
# побеждают, остальные ключи сохраняются.
# Сам claude ставится через npm (~/.npm-global).
# ==========================================================
{ lib, pkgs, ... }:

let
  settings = {
    model = "opus";
    effortLevel = "high";
    tui = "fullscreen";

    # Без подписи Claude в коммитах и PR
    attribution = {
      commit = "";
      pr = "";
    };
  };

  declared = pkgs.writeText "claude-settings.json" (builtins.toJSON settings);
  jq = "${pkgs.jq}/bin/jq";
in
{
  home.activation.claudeSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    target="$HOME/.claude/settings.json"
    run mkdir -p "$HOME/.claude"
    if [[ -s "$target" ]] && ${jq} empty "$target" 2>/dev/null; then
      tmp="$(mktemp)"
      ${jq} -s '.[0] * .[1]' "$target" ${declared} > "$tmp"
      run mv "$tmp" "$target"
    else
      run install -m0644 ${declared} "$target"
    fi
  '';
}
