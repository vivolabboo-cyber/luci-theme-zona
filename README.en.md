<p align="center"><img src="docs/images/login-en.png" alt="ZONA login preview — synthetic data" width="100%"></p>

# ZONA · OpenWrt LuCI theme

**An atmospheric charcoal-and-olive interface, amber controls, and a Chornobyl Shelter backdrop.**

[Русский](README.md) · [Security](SECURITY.md) · [License](LICENSE)

## Features

Custom login using standard LuCI authentication; responsive sidebar and forms; Russian/English labels following LuCI language; reduced-motion support; read-only load/memory/uptime summary and optional Raspberry Pi temperature. No installed Argon package is required. The base CSS/menu are attributed derivatives of Argon 3.1.1 under Apache-2.0. The companion [Observatory](https://github.com/vivolabboo-cyber/luci-app-observatory) includes a matching palette.

## Install and recover

Over SSH as root, download the installer:

```sh
wget -O /tmp/luci-theme-zona-install.sh https://github.com/vivolabboo-cyber/luci-theme-zona/releases/download/v1.1.1/bootstrap.sh
```

Review the script, then run:

```sh
sh /tmp/luci-theme-zona-install.sh --activate
```

The installer downloads a pinned release over HTTPS and checks the archive SHA-256. A checksum is not a signature: you still trust GitHub and the installer.

`--activate` enables the theme immediately.

Manual installation:

Requires ucode-based LuCI. The original version was tested on Raspberry Pi 4 / OpenWrt 25.12.6. The bilingual version is locally tested; compatibility with other firmware versions is not guaranteed.

Download sources or a release archive, verify SHA256SUMS, copy to your router, and keep a normal OpenWrt backup plus working SSH and Bootstrap fallback. Run `sh install.sh --activate` as root. The script saves overwritten files and LuCI configuration under private `/root/zona-backup-*`; omitting `--activate` only registers the theme. Refresh the browser. Choose English or Russian under System → System → Language and Style. Standard Russian pages require `luci-i18n-base-ru`.

`sh uninstall.sh` selects the installed Bootstrap fallback before removing this theme's files. Backups are retained. Router credentials, networking, DNS and VPN configuration are not modified. Never pipe an unreviewed remote script into a shell.

## Build and attribution

Run `python3 tools/check.py`, then `python3 tools/package.py` for an allowlisted archive and SHA256SUMS in `dist/`. Use the included Makefile in a matching OpenWrt SDK for IPK/APK. Releases are not cryptographically signed.

## Privacy

The theme sends no telemetry. Authentication uses standard LuCI mechanisms.

## Licenses

Based on Argon 3.1.1 and distributed under Apache-2.0. See [NOTICE](NOTICE) for author and asset attribution.
