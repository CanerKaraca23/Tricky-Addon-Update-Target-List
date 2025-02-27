MODPATH=${0%/*}
TS="/data/adb/modules/tricky_store"
SCRIPT_DIR="/data/adb/tricky_store"

# Enable back TSupport-A auto update
if [ -f "/storage/emulated/0/stop-tspa-auto-target" ]; then
    rm -f "/storage/emulated/0/stop-tspa-auto-target"
fi

# Remove residue and restore aosp keybox.
rm -rf "/data/adb/modules/.TA_utl"
rm -f "/data/adb/boot_hash"
rm -f "/data/adb/security_patch"
rm -f "/data/adb/tricky_store/target_from_denylist"
rm -f "/data/adb/tricky_store/system_app"
if [ -d "$TS" ]; then
    [ -L "$TS/webroot" ] && rm -f "$TS/webroot"
    [ -L "$TS/action.sh" ] && rm -f "$TS/action.sh"
fi
mv -f "$SCRIPT_DIR/keybox.xml" "$SCRIPT_DIR/keybox.xml.bak"
xxd -r -p "$MODPATH/common/.default" | base64 -d > "$SCRIPT_DIR/keybox.xml"
