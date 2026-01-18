#!/usr/bin/env bash
set -euo pipefail

# Если хочешь жестко привязаться к конкретной клаве — впиши её имя:
# (посмотри: hyprctl devices -j | jq -r '.keyboards[].name')
KBD_NAME="${KBD_NAME:-logitech-usb-keyboard}"

# Если такой клавы нет (например, отключена) — берём первую попавшуюся
kbd_json="$(hyprctl devices -j)"
kbd="$(echo "$kbd_json" | jq -r --arg n "$KBD_NAME" '
  (.keyboards[] | select(.name==$n) | .name) // (.keyboards[0].name // empty)
')"

layout="$(echo "$kbd_json" | jq -r --arg n "$kbd" '
  (.keyboards[] | select(.name==$n) | .active_keymap) // empty
')"

# Текст + класс
text="⌨ ?"
class="unk"

case "$layout" in
  *English*|*англ*|*US*)
    text="🇺🇸 EN"
    class="en"
    ;;
  *Russian*|*Русский*|*RU*)
    text="🇷🇺 RU"
    class="ru"
    ;;
esac

# JSON (минимальный)
printf '{"text":"%s","class":"%s","tooltip":"%s"}\n' \
  "$text" \
  "$class" \
  "${layout:-unknown}"

