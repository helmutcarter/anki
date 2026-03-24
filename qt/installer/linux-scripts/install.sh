#!/bin/bash

set -e

if [ "$(dirname "$(realpath "$0")")" != "$(realpath "$PWD")" ]; then
  echo "Please run from the folder install.sh is in."
  exit 1
fi

if [ "$PREFIX" = "" ]; then
	PREFIX=/usr/local
fi

rm -rf "$PREFIX"/share/anki "$PREFIX"/bin/anki
# Copy bin/lib/share directories
for dir in */; do
    if [ -d "$dir" ]; then
        cp -av --no-preserve=owner,context -- "$dir" "$PREFIX"
    fi
done
mkdir -p "$PREFIX"/share/anki
cp -av --no-preserve=owner,context -- * README.md install.sh uninstall.sh anki.xml "$PREFIX"/share/anki/

# Correct default executable path
sed -i "s|/usr/bin/||g" "$PREFIX"/share/applications/net.ankiweb.anki.desktop

# fix a previous packaging issue where we created this as a file
(test -f "$PREFIX"/share/applications && rm "$PREFIX"/share/applications)||true

xdg-mime install anki.xml --novendor
xdg-mime default net.ankiweb.anki.desktop application/x-colpkg
xdg-mime default net.ankiweb.anki.desktop application/x-apkg
xdg-mime default net.ankiweb.anki.desktop application/x-ankiaddon

rm install.sh

echo "Install complete. Type 'anki' to run."
