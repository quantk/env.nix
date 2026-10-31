# envix

Декларативное окружение на **NixOS + Home Manager** (flake) для хоста `quantnix`:
Hyprland под Wayland на NVIDIA, терминал Ghostty + zsh/Powerlevel10k, Neovim на базе kickstart.nvim, Docker и k3s.

## Что внутри

| Слой | Состав |
|------|--------|
| Загрузка | GRUB (UEFI), `linuxPackages_latest`, тихий boot + Plymouth (`owl`) |
| Графика | NVIDIA (проприетарный драйвер, modesetting), Hyprland + XWayland |
| Сессия | greetd + tuigreet, waybar, wofi, mako, wlogout, hyprlock, hyprpaper, hyprsunset |
| Звук / печать | PipeWire + WirePlumber, CUPS + Avahi |
| Терминал | Ghostty, zsh (oh-my-zsh + Powerlevel10k), direnv + nix-direnv |
| Разработка | Neovim (kickstart.nvim), VS Code, Zed, IDEA, Go, Python (uv), Node, Rust, JDK 21 |
| Сервисы | Docker 25, k3s (одноузловой, kubectl без sudo) |
| Nix | flakes, `nh` с еженедельной очисткой (`--keep 3`), nix-ld, unfree |

### Flake inputs

- `nixpkgs` — `nixos-unstable`
- `home-manager` — подключён как модуль NixOS
- `nix-vscode-extensions` — оверлей `pkgs.vscode-marketplace.*`
- `llm-agents` — оверлей `pkgs.llm-agents.*` (opencode и др.)
- `codex-desktop-linux` — HM-модуль Codex Desktop

## Структура

```
flake.nix                  # inputs, сборка хоста + Home Manager
hosts/quantnix/            # система
├── default.nix            # точка входа, timezone, stateVersion
├── hardware-configuration.nix
├── system/                # boot, nix, users (+sudo), networking
├── hardware/              # nvidia, audio, print
├── desktop/               # hyprland, greetd, fonts
├── services/              # docker, k3s
└── packages.nix           # системные пакеты
home/quantick/             # пользователь (Home Manager)
├── default.nix            # точка входа, xdg mimeApps
├── desktop/               # hypr/, waybar/, wofi/, mako/, wlogout/, flameshot.nix
├── terminal/              # ghostty, zsh, direnv
├── dev/                   # git, nvim/, vscode
└── packages.nix           # пользовательские приложения
```

Конфиги в родных форматах (`.conf`, `.jsonc`, `.css`) лежат рядом со своими модулями.

## Использование

```sh
# применить систему + Home Manager
sudo nixos-rebuild switch --flake .#quantnix

# собрать и активировать без добавления в загрузчик
sudo nixos-rebuild test --flake .#quantnix

# только собрать
nix build .#nixosConfigurations.quantnix.config.system.build.toplevel

# обновить inputs
nix flake update
```

Алиасы zsh: `nr` (rebuild switch), `nu` (flake update), `ngc` (сборка мусора), `hr` (`hyprctl reload`).

> Flake видит только файлы, отслеживаемые git: новые файлы нужно `git add` перед сборкой.

### Установка на новую машину

1. Установить NixOS, склонировать репозиторий в `~/envix`.
2. Заменить `hosts/quantnix/hardware-configuration.nix` на сгенерированный `nixos-generate-config`.
3. Поправить под себя: пользователя (`system/users.nix`, `home/quantick/`), монитор в `hyprland.conf`, git-идентичность в `dev/git.nix`.
4. `sudo nixos-rebuild switch --flake .#quantnix`.

## Горячие клавиши Hyprland

| Клавиши | Действие |
|---------|----------|
| `Super+Enter` | Ghostty |
| `Super+A` | wofi (лаунчер) |
| `Print` | flameshot (скриншот области) |
| `Super+Q` | закрыть окно |
| `Super+F` | максимизировать |
| `Super+H/J/K/L` | фокус влево/вниз/вверх/вправо |
| `Super+1…0` | рабочий стол 1–10 |
| `Super+Shift+1…0` | перенести окно на рабочий стол |
| `Super+ЛКМ / ПКМ` | двигать / ресайзить окно |
| `Super+Shift+L` | hyprlock |
| `Super+Shift+Q` | выйти из Hyprland |
| `Ctrl+Alt+Del` | wlogout |

Полный список: `hyprctl binds` (алиас `hb`).

## Соглашения

- Каждый пакет объявлен ровно в одном месте; пакеты подсистемы — в её модуле.
- Форматирование: `nixpkgs-fmt`, отступ 2 пробела.
- Секреты в репозиторий не коммитятся.
- Файрвол отключён (`system/networking.nix`) — включить, если машина в недоверенной сети.
