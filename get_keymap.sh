#!/bin/bash
set -e

echo "Preprocessing keymap..."
pcpp --passthru-unfound-includes \
  -I zmk-nodefree-config \
  config/totem.keymap \
  > totem_preprocessed.keymap

echo "Stripping directives..."
grep -v "^#" totem_preprocessed.keymap > totem_clean.keymap

echo "Parsing keymap..."
keymap parse -z totem_clean.keymap > totem.yaml

echo "Drawing SVG..."
keymap draw totem.yaml \
  --qmk-keyboard geigeigeist/totem \
  > keymap.svg

echo "Cleaning up temp files..."
rm totem_preprocessed.keymap totem_clean.keymap totem.yaml

echo "Done! Open keymap.svg to see your layout."
