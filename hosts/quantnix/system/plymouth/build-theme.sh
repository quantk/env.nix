# Сборка одной темы envix: build-theme.sh <имя> <цвет> <описание>
# Вызывается из themes.nix; рядом лежат scripts/*.script, в $out — результат.
set -euo pipefail

name=$1
color=$2
desc=$3
dir=$out/share/plymouth/themes/envix-$name
mkdir -p "$dir"

# Точки под каждый размер: яркое ядро со сглаженным краем + мягкое свечение
for k in $(seq 2 40); do
  magick -size "${k}x${k}" xc:"$color" -alpha set -channel A \
    -fx 'dd=hypot(i+0.5-w/2,j+0.5-h/2); rr=w*0.3; ce=min(max(rr-dd+0.5,0),1); gl=0.45*exp(-pow((dd-rr)/(w*0.14),2)); max(ce,gl)' \
    +channel "$dir/dot-$k.png"
done

# Логотип NixOS в цвете темы (160px — размер на 2K)
rsvg-convert -a -w 160 -h 160 "$snowflake" |
  magick - -fill "$color" -colorize 100 "$dir/logo.png"

cat scripts/common-head.script "scripts/$name.script" scripts/common-tail.script \
  >"$dir/envix-$name.script"

cat >"$dir/envix-$name.plymouth" <<EOF
[Plymouth Theme]
Name=envix-$name
Description=$desc
ModuleName=script

[script]
ImageDir=$dir
ScriptFile=$dir/envix-$name.script
EOF
