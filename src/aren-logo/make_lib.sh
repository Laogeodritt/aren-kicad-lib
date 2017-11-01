#! /usr/bin/env bash


target_dir=../../aren-symbols.pretty
target_sizes="4 5 6 7 8 9"
precision=4
script=~/.virtualenvs/kicad-tools/opt/svg2mod/svg2mod.py

if [ !-f "$script" ]; then
    echo "Script seems to no longer be at '$script'... Go set up your environment, Marc =P"
fi

if [ !-d "${target_dir}" ]; then
    mkdir -p "${target_dir}"
fi

for f in symbol logo; do
    python2 $script -i arenthil-${f}-kicad-silks-10mm.svg --name arenthil-${f}-10mm -o "${target_dir}"/arenthil-${f}-10mm.kicad_mod -p $precision
    for i in $target_sizes; do
        python2 $script -i arenthil-${f}-kicad-silks-10mm.svg --name arenthil-${f}-${i}mm -o "${target_dir}"/arenthil-${f}-${i}mm.kicad_mod -p $precision -f 0.${i}
    done
done

for f in "$target_dir"/arenthil-*; do
    sed -i 's/(attr smd)/(attr virtual)/' "${f}"
done

