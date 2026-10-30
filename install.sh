#!/bin/sh
set -eu
[ "$(id -u)" -eq 0 ] || { echo 'Run as root on OpenWrt.' >&2; exit 1; }
[ -f /etc/openwrt_release ] || { echo 'This installer requires OpenWrt.' >&2; exit 1; }
[ -f /usr/share/ucode/luci/runtime.uc ] || [ -d /usr/share/ucode/luci/template ] || { echo 'ucode-based LuCI is required.' >&2; exit 1; }
command -v uci >/dev/null || { echo 'LuCI/UCI is required.' >&2; exit 1; }
[ -f /etc/config/luci ] || { echo 'LuCI configuration is missing.' >&2; exit 1; }
cd "$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
umask 077
backup="/root/zona-backup-$(date +%Y%m%d-%H%M%S)-$$"
mkdir -p "$backup/files"
find root -type f | while IFS= read -r src; do
    rel=${src#root/}
    case "$rel" in /*|*..*) echo 'Invalid package path' >&2; exit 1;; esac
    dest="/$rel"
    if [ -e "$dest" ]; then
        mkdir -p "$backup/files/$(dirname "$rel")"
        cp -p "$dest" "$backup/files/$rel"
    fi
    mkdir -p "$(dirname "$dest")"
    cp "$src" "$dest"
    chmod 644 "$dest"
done
echo "Backup: $backup"

cp -p /etc/config/luci "$backup/luci"
uci set luci.themes.Zona='/luci-static/zona'
if [ "${1:-}" = '--activate' ]; then
    uci set luci.main.mediaurlbase='/luci-static/zona'
fi
uci commit luci
echo 'Installed. Select Zona in LuCI or use --activate. No network services restarted.'
