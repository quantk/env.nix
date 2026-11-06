<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:0f172a,50:1e3a8a,100:3b82f6&height=220&section=header&text=envix&fontSize=90&fontColor=e7e7ea&fontAlignY=38&desc=Hyprland%20%C2%B7%20NixOS%20%C2%B7%20Home%20Manager&descAlignY=60&descSize=20&animation=fadeIn" alt="envix" width="100%"/>

<a href="#">
  <img src="https://readme-typing-svg.demolab.com?font=JetBrains+Mono&weight=600&size=20&duration=3000&pause=800&color=3B82F6&center=true&vCenter=true&width=600&lines=%E2%9D%84%EF%B8%8F+%D0%BE%D0%B4%D0%B8%D0%BD+flake+%E2%80%94+%D0%B2%D1%81%D1%8F+%D1%81%D0%B8%D1%81%D1%82%D0%B5%D0%BC%D0%B0;%F0%9F%AA%9F+Hyprland+%2B+Wayland+%D0%BD%D0%B0+NVIDIA;%F0%9F%91%BB+Ghostty+%2B+zsh+%2B+Powerlevel10k;%F0%9F%93%9D+Neovim+%D0%BD%D0%B0+%D0%B1%D0%B0%D0%B7%D0%B5+kickstart.nvim;%E2%98%B8%EF%B8%8F+Docker+%2B+k3s+%D0%B8%D0%B7+%D0%BA%D0%BE%D1%80%D0%BE%D0%B1%D0%BA%D0%B8" alt="typing"/>
</a>

<br/>

[![NixOS](https://img.shields.io/badge/NixOS-unstable-5277C3?style=for-the-badge&logo=nixos&logoColor=white)](https://nixos.org)
[![Flakes](https://img.shields.io/badge/Nix-Flakes-7EBAE4?style=for-the-badge&logo=snowflake&logoColor=white)](https://nixos.wiki/wiki/Flakes)
[![Home Manager](https://img.shields.io/badge/Home_Manager-module-1e3a8a?style=for-the-badge&logo=homeassistant&logoColor=white)](https://github.com/nix-community/home-manager)
[![Hyprland](https://img.shields.io/badge/Hyprland-Wayland-58E1FF?style=for-the-badge&logo=wayland&logoColor=black)](https://hyprland.org)
[![NVIDIA](https://img.shields.io/badge/NVIDIA-proprietary-76B900?style=for-the-badge&logo=nvidia&logoColor=white)](https://www.nvidia.com)

![Last commit](https://img.shields.io/github/last-commit/quantk/env.nix?style=flat-square&color=3b82f6&labelColor=0f172a)
![Repo size](https://img.shields.io/github/repo-size/quantk/env.nix?style=flat-square&color=3b82f6&labelColor=0f172a)
![Stars](https://img.shields.io/github/stars/quantk/env.nix?style=flat-square&color=3b82f6&labelColor=0f172a)

<br/>

**Декларативное окружение на NixOS + Home Manager для хоста `quantnix`.**<br/>
Одна команда — и машина в точности такая, как описано в репозитории.

<br/>

<img src="https://skillicons.dev/icons?i=nix,linux,neovim,vscode,docker,kubernetes,go,py,nodejs,rust,java,bash&theme=dark" alt="stack"/>

<br/><br/>

[Что внутри](#-что-внутри) •
[Архитектура](#-архитектура) •
[Быстрый старт](#-быстрый-старт) •
[Горячие клавиши](#%EF%B8%8F-горячие-клавиши-hyprland) •
[Соглашения](#-соглашения)

</div>

<!--
  📸 Скриншот рабочего стола: положите файл в .github/assets/screenshot.png и раскомментируйте
<p align="center"><img src=".github/assets/screenshot.png" width="90%" style="border-radius:12px"/></p>
-->

---

## ✨ Что внутри

| | Слой | Состав |
|:-:|------|--------|
| 🚀 | **Загрузка** | GRUB (UEFI), `linuxPackages_latest`, тихий boot + Plymouth (`owl`) |
| 🎮 | **Графика** | NVIDIA (проприетарный драйвер, modesetting), Hyprland + XWayland |
| 🪟 | **Сессия** | greetd + tuigreet, waybar, wofi, mako, wlogout, hyprlock, hyprpaper, hyprsunset |
| 🔊 | **Звук / печать** | PipeWire + WirePlumber, CUPS + Avahi |
| 👻 | **Терминал** | Ghostty, zsh (oh-my-zsh + Powerlevel10k), direnv + nix-direnv |
| 🛠️ | **Разработка** | Neovim (kickstart.nvim), VS Code, Zed, IDEA, Go, Python (uv), Node, Rust, JDK 21 |
| 🐳 | **Сервисы** | Docker 25, k3s (одноузловой, kubectl без sudo) |
| ❄️ | **Nix** | flakes, `nh` с еженедельной очисткой (`--keep 3`), nix-ld, unfree |

### 📦 Flake inputs

| Input | Назначение |
|-------|-----------|
| [`nixpkgs`](https://github.com/NixOS/nixpkgs) | `nixos-unstable` — rolling release |
| [`home-manager`](https://github.com/nix-community/home-manager) | подключён как модуль NixOS |
| [`nix-vscode-extensions`](https://github.com/nix-community/nix-vscode-extensions) | оверлей `pkgs.vscode-marketplace.*` |
| [`llm-agents`](https://github.com/numtide/llm-agents.nix) | оверлей `pkgs.llm-agents.*` (opencode и др.) |
| [`codex-desktop-linux`](https://github.com/ilysenko/codex-desktop-linux) | HM-модуль Codex Desktop |

---

## 🧬 Архитектура

```mermaid
flowchart LR
    F(["❄️ flake.nix"]):::root

    F --> H["🖥️ hosts/quantnix"]:::sys
    F --> HM["🏠 home-manager"]:::home
    HM --> U["👤 home/quantick"]:::home

    H --> S1["⚙️ system<br/>boot · nix · users · net"]:::sys
    H --> S2["🔩 hardware<br/>nvidia · audio · print"]:::sys
    H --> S3["🪟 desktop<br/>hyprland · greetd · fonts"]:::sys
    H --> S4["🐳 services<br/>docker · k3s"]:::sys

    U --> U1["🎨 desktop<br/>hypr · waybar · wofi · mako"]:::home
    U --> U2["👻 terminal<br/>ghostty · zsh · direnv"]:::home
    U --> U3["🛠️ dev<br/>git · nvim · vscode"]:::home

    classDef root fill:#3b82f6,stroke:#1e3a8a,color:#fff,font-weight:bold
    classDef sys fill:#0f172a,stroke:#3b82f6,color:#e7e7ea
    classDef home fill:#1e293b,stroke:#58e1ff,color:#e7e7ea
```

<details>
<summary><b>📁 Дерево файлов</b></summary>

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

</details>

---

## 🚀 Быстрый старт

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

| Алиас | Команда |
|:-----:|---------|
| `nr` | rebuild switch |
| `nu` | flake update |
| `ngc` | сборка мусора |
| `hr` | `hyprctl reload` |
| `hb` | `hyprctl binds` |

> [!IMPORTANT]
> Flake видит только файлы, отслеживаемые git: новые файлы нужно `git add` перед сборкой.

<details>
<summary><b>💿 Установка на новую машину</b></summary>

1. Установить NixOS, склонировать репозиторий в `~/envix`.
2. Заменить `hosts/quantnix/hardware-configuration.nix` на сгенерированный `nixos-generate-config`.
3. Поправить под себя: пользователя (`system/users.nix`, `home/quantick/`), монитор в `hyprland.conf`, git-идентичность в `dev/git.nix`.
4. `sudo nixos-rebuild switch --flake .#quantnix`.

</details>

---

## ⌨️ Горячие клавиши Hyprland

<table>
<tr><td valign="top">

| Клавиши | Действие |
|---------|----------|
| <kbd>Super</kbd> + <kbd>Enter</kbd> | Ghostty |
| <kbd>Super</kbd> + <kbd>A</kbd> | wofi (лаунчер) |
| <kbd>Print</kbd> | flameshot (область) |
| <kbd>Super</kbd> + <kbd>Q</kbd> | закрыть окно |
| <kbd>Super</kbd> + <kbd>F</kbd> | максимизировать |
| <kbd>Super</kbd> + <kbd>H</kbd><kbd>J</kbd><kbd>K</kbd><kbd>L</kbd> | фокус ← ↓ ↑ → |

</td><td valign="top">

| Клавиши | Действие |
|---------|----------|
| <kbd>Super</kbd> + <kbd>1</kbd>…<kbd>0</kbd> | рабочий стол 1–10 |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>1</kbd>…<kbd>0</kbd> | перенести окно |
| <kbd>Super</kbd> + <kbd>ЛКМ</kbd> / <kbd>ПКМ</kbd> | двигать / ресайзить |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>L</kbd> | hyprlock |
| <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>Q</kbd> | выйти из Hyprland |
| <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>Del</kbd> | wlogout |

</td></tr>
</table>

Полный список: `hyprctl binds` (алиас `hb`).

---

## 📐 Соглашения

- 📍 Каждый пакет объявлен ровно в одном месте; пакеты подсистемы — в её модуле.
- 🎯 Форматирование: `nixpkgs-fmt`, отступ 2 пробела.
- 🔐 Секреты в репозиторий не коммитятся.

> [!WARNING]
> Файрвол отключён (`system/networking.nix`) — включить, если машина в недоверенной сети.

<div align="center">

<br/>

<sub>Built with ❄️ Nix and a lot of ☕</sub>

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:3b82f6,50:1e3a8a,100:0f172a&height=120&section=footer" width="100%"/>

</div>
