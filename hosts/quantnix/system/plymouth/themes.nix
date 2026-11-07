# ==========================================================
# Свои Plymouth-темы envix — процедурная анимация из точек.
# Весят килобайты и чёткие на любом разрешении:
# геометрия считается от размера экрана, точки отрисованы
# заранее под каждый размер.
# ==========================================================
{ lib, stdenvNoCC, imagemagick, librsvg, nixos-icons }:

let
  # Цвета — из палитры waybar
  themes = {
    ripple = { color = "#b4a7ff"; description = "Дышащий логотип и расходящиеся кольца"; };
    orbit = { color = "#8aa4ff"; description = "Орбиты точек сплетаются в спирали"; };
    helix = { color = "#a6e3c4"; description = "Вращающаяся двойная спираль"; };
    comet = { color = "#f5a3d7"; description = "Комета рисует перетекающую фигуру Лиссажу"; };
    pulse = { color = "#ffc79a"; description = "Волны света по сетке на весь экран"; };
  };
in
stdenvNoCC.mkDerivation {
  pname = "envix-plymouth-themes";
  version = "1.0";

  src = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [ ./scripts ./build-theme.sh ];
  };

  nativeBuildInputs = [ imagemagick librsvg ];

  snowflake = "${nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake-white.svg";

  installPhase = ''
    runHook preInstall
    ${lib.concatStrings (lib.mapAttrsToList (name: t: ''
      bash build-theme.sh ${name} '${t.color}' '${t.description}'
    '') themes)}
    runHook postInstall
  '';

  passthru.themeNames = map (n: "envix-${n}") (lib.attrNames themes);
}
