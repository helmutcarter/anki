#!/bin/bash

set -e

if [ "$PREFIX" = "" ]; then
	PREFIX=/usr/local
fi

echo "Uninstalling Anki..."
xdg-mime uninstall "$PREFIX"/share/anki/anki.xml || true

rm -rf "$PREFIX"/share/anki
rm -rf "$PREFIX"/bin/anki
rm -rf "$PREFIX"/lib/anki
rm -rf "$PREFIX"/share/applications/net.ankiweb.anki.desktop
rm -rf "$PREFIX"/share/doc/anki
rm -rf "$PREFIX"/share/icons/hicolor/*/apps/net.ankiweb.anki.png
rm -rf "$PREFIX"/share/man/man1/anki.1.gz

echo "Uninstall complete."
