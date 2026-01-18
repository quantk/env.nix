#!/usr/bin/env bash
set -euo pipefail

LOC="orekhovo-zuevo"   # можно поменять
WTTR="https://wttr.in/${LOC}"

# Одна строка для бара (коротко и аккуратно)
# format=1 обычно даёт что-то вроде: "⛅️ +2°C"
text="$(curl -fsS --max-time 30 "${WTTR}?format=1" 2>/dev/null || true)"

# Tooltip: компактный прогноз (без ANSI-артов), чтобы не было каши в подсказке
# 0 = только сегодня, T = убрать "Follow", Q = quiet (без лишнего)
tooltip="$(curl -fsS --max-time 30 "${WTTR}?0&T&Q" 2>/dev/null || true)"

# Фолбэк, если сеть/сервис недоступны
if [[ -z "${text}" ]]; then
  text="󰤮 --"
  tooltip="wttr.in недоступен"
  class="down"
else
  class="ok"
fi

# Экранируем для JSON
json_escape() {
  # экранируем \ и " + переводим новые строки в \n
  printf '%s' "$1" | sed -e 's/\\/\\\\/g' -e 's/"/\\"/g' -e ':a;N;$!ba;s/\n/\\n/g'
}

printf '{"text":"%s","tooltip":"%s","class":"%s"}\n' \
  "$(json_escape "$text")" \
  "$(json_escape "$tooltip")" \
  "$class"

