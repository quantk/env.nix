# Repository Guidelines

## Project Structure & Module Organization
- `flake.nix` defines the NixOS configuration output and inputs.
- `hosts/quantnix/` contains machine-specific NixOS modules (boot, networking, audio, GPU, packages, users, Hyprland).
- `home/quantick/` holds Home Manager modules for user apps and UI (e.g., `hypr/`, `waybar/`, `kitty/`, `nvim/`, `mako/`, `wofi/`).
- Config assets live alongside their modules (e.g., `home/quantick/waybar/config.jsonc`, `home/quantick/wofi/style.css`).

## Build, Test, and Development Commands
- `nixos-rebuild switch --flake .#quantnix` applies the full system + Home Manager configuration.
- `nixos-rebuild test --flake .#quantnix` builds and boots the new config for a test session.
- `nix build .#nixosConfigurations.quantnix.config.system.build.toplevel` builds the system closure without switching.
- `nix flake show` inspects available outputs.

## Coding Style & Naming Conventions
- Nix files use two-space indentation and consistent attribute alignment.
- Keep modules focused by area (e.g., `boot.nix`, `audio.nix`), and add new modules under `hosts/quantnix/` or `home/quantick/` accordingly.
- Format Nix with `nixpkgs-fmt` (installed via `home/quantick/apps.nix`; VS Code config sets `nix.formatterPath`).
- Config files keep their native formats (JSONC, CSS, INI-like configs).

## Testing Guidelines
- No unit test suite is defined. Validate changes by running `nixos-rebuild test --flake .#quantnix`.
- For UI changes (Waybar, Hyprland, Wofi), verify by logging into the session and checking affected components.

## Commit & Pull Request Guidelines
- Commit messages in history are short and direct (e.g., `Refactoring`, `flameshot`). Keep to a concise summary line.
- PRs should explain which module(s) changed, include the applied command used, and attach screenshots for UI changes.

## Security & Configuration Tips
- Keep secrets out of tracked files; prefer environment variables or system-specific modules if needed.
- When adding services, confirm they align with `security.sudo` and user settings in `hosts/quantnix/users.nix`.
