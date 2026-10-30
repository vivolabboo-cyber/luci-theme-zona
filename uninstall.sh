#!/bin/sh
set -eu
[ "$(id -u)" -eq 0 ] || exit 1
cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
# Restore a known installed theme before removing this theme's own files.
if [ "$(uci -q get luci.main.mediaurlbase || true)" = '/luci-static/zona' ]; then
    [ -d /www/luci-static/bootstrap ] || { echo 'Install/select a fallback theme first.' >&2; exit 1; }
    uci set luci.main.mediaurlbase='/luci-static/bootstrap'
fi
uci -q delete luci.themes.Zona || true
uci commit luci
find root -type f | while IFS= read -r src; do
    case "$src" in root/www/luci-static/zona/*|root/www/luci-static/resources/menu-zona.js|root/www/luci-static/resources/zona-overview.js|root/usr/share/ucode/luci/template/themes/zona/*|root/usr/share/licenses/luci-theme-zona/*|root/lib/upgrade/keep.d/zona-theme) rm -f "/${src#root/}";; *) echo 'Skipped unexpected path' >&2;; esac
done
echo 'Theme removed. Backups preserved.'
