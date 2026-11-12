#!/usr/bin/env bash
# ==========================================================
# Живые обои через linux-wallpaperengine
#
#   wallpaper.sh            — запустить сохранённые обои
#   wallpaper.sh <id>       — поставить обои из Workshop и запомнить
#
# <id> — число из ссылки Workshop (…/filedetails/?id=<id>)
# или имя папки в steamapps/workshop/content/431960/
# Нет сохранённых обоев → статичные через hyprpaper.
# ==========================================================
set -u

MONITOR="HDMI-A-2"
FPS=60
STATE="${XDG_STATE_HOME:-$HOME/.local/state}/wallpaper-id"
WORKSHOP="$HOME/.local/share/Steam/steamapps/workshop/content/431960"

if [ $# -gt 0 ]; then
  # Не запоминаем обои, которых нет на диске — иначе после перелогина пусто
  if [ ! -d "$WORKSHOP/$1" ]; then
    echo "Обои $1 не скачаны: подпишись в Workshop и дождись загрузки в Steam" >&2
    exit 1
  fi
  mkdir -p "$(dirname "$STATE")"
  echo "$1" > "$STATE"
fi

# Имя процесса обрезается до 15 символов, поэтому -f, а не -x
pkill -f linux-wallpaperengine
pkill -x hyprpaper

id="$(cat "$STATE" 2>/dev/null || true)"
if [ -z "$id" ]; then
  exec hyprpaper
fi

exec linux-wallpaperengine \
  --silent \
  --layer background \
  --fps "$FPS" \
  --screen-root "$MONITOR" \
  --bg "$id" \
  --scaling fill
