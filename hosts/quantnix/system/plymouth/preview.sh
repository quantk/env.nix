# plymouth-preview — посмотреть Plymouth-тему в окне, без sudo и перезагрузки.
#
#   plymouth-preview                   все темы envix по очереди
#   plymouth-preview envix-orbit owl   конкретные темы (любые установленные)
#   -t 20                              секунд на тему (по умолчанию 15)
#   --shutdown                         режим выключения
#   --password                         показать запрос пароля
#   --list                             список доступных тем
#
# Как работает: plymouthd запускается в user+mount namespace
# (там он «root»), рендерит через x11 в окно 2560×1440, а каталог
# тем подменяется на свои + системные.

orig=("$@")
seconds=15
mode=boot
password=0
names=()

while (($#)); do
  case $1 in
    -t) seconds=$2; shift ;;
    --shutdown) mode=shutdown ;;
    --password) password=1 ;;
    --list)
      for d in "$ENVIX_THEMES"/* /etc/plymouth/themes/*; do basename "$d"; done | sort -u
      exit 0 ;;
    -h | --help)
      echo "plymouth-preview [-t сек] [--shutdown] [--password] [--list] [тема…]"
      exit 0 ;;
    *) names+=("$1") ;;
  esac
  shift
done

if [[ -z ${ENVIX_PREVIEW_INNER:-} ]]; then
  [[ -n ${DISPLAY:-} ]] || { echo "Нужна графическая сессия (DISPLAY пуст)" >&2; exit 1; }
  ENVIX_PREVIEW_INNER=1 exec unshare --map-root-user --mount -- "$0" "${orig[@]}"
fi

# --- внутри namespace ---
tmp=$(mktemp -d)
trap 'plymouth quit 2>/dev/null; rm -rf "$tmp"' EXIT

mkdir "$tmp/themes"
for d in /etc/plymouth/themes/* "$ENVIX_THEMES"/*; do
  ln -sfn "$(readlink -f "$d")" "$tmp/themes/$(basename "$d")"
done
mount --bind "$tmp/themes" /run/plymouth/themes

if ((${#names[@]} == 0)); then
  for d in "$ENVIX_THEMES"/*; do names+=("$(basename "$d")"); done
fi

for name in "${names[@]}"; do
  if [[ ! -e $tmp/themes/$name/$name.plymouth ]]; then
    echo "Нет темы: $name (см. --list)" >&2
    continue
  fi
  echo "▶ $name  ($seconds с, $mode)"

  rm -f "$tmp/pid"
  plymouthd --mode="$mode" --no-boot-log --pid-file="$tmp/pid" \
    --kernel-command-line="quiet splash plymouth.splash=$name"
  plymouth show-splash

  # окно x11 — на весь экран поверх waybar
  if command -v hyprctl >/dev/null; then
    for _ in $(seq 20); do [[ -s $tmp/pid ]] && break; sleep 0.05; done
    pid=$(cat "$tmp/pid" 2>/dev/null || pgrep -n -x plymouthd || echo 0)
    addr=
    for _ in $(seq 30); do
      addr=$(hyprctl clients -j | jq -r --argjson p "$pid" '.[] | select(.pid == $p) | .address')
      [[ -n $addr ]] && break
      sleep 0.1
    done
    if [[ -n $addr ]]; then
      hyprctl -q dispatch focuswindow "address:$addr"
      hyprctl -q dispatch fullscreen 0
    fi
  fi

  if ((password)); then
    sleep 3
    plymouth ask-for-password --prompt="Пароль" >/dev/null 2>&1 &
    sleep $((seconds - 3))
  else
    sleep "$seconds"
  fi

  plymouth quit
  sleep 0.5
done
