#!/usr/bin/env bash
#
# KDE + Custom Backup Script
#

# Check user
if [ "$EUID" -eq 0 ]; then
    echo "Please run as a normal user, not root"
    exit 1
fi

# Backup folder
BACKUP_DIR="$HOME/kde-backup"
mkdir -p "$BACKUP_DIR/config"

echo "Creating backup in: $BACKUP_DIR"

# --- CONFIG files ---
CONFIG_FILES=(
    "backup-config.sh"
    "kdeglobals"
    "kscreenlockerrc"
    "plasmarc"
    "plasma-org.kde.plasma.desktop-appletsrc"
    "kglobalshortcutsrc"
    "kwinrc"
)

for f in "${CONFIG_FILES[@]}"; do
    if [ -f "$HOME/.config/$f" ]; then
        cp "$HOME/.config/$f" "$BACKUP_DIR/config/"
        echo "Backing up $f"
    fi
done

# --- Directories in config ---
CONFIG_DIRS=(
    "autostart"             # KDE + Conky autostart .desktop files
    "konsole"               # Konsole profiles
    "conky"                 # Conky configs
    "wallpaper"             # Wallpaper configs
)

for d in "${CONFIG_DIRS[@]}"; do
    if [ -d "$HOME/.config/$d" ]; then
        cp -r "$HOME/.config/$d" "$BACKUP_DIR/config/"
        echo "Backing up folder $d"
    fi
done

echo "Backup complete ✅"
echo "All files are in: $BACKUP_DIR"
