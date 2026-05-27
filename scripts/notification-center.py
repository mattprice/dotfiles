#!/usr/bin/env python3
import argparse
import os
import plistlib
import subprocess
import sys

PLIST = os.path.expanduser(
    "~/Library/Group Containers/group.com.apple.usernoted/"
    "Library/Preferences/group.com.apple.usernoted.plist"
)

# https://github.com/jacobsalmela/NCutil/blob/master/NCutil.py#L225
DONT_SHOW_IN_CENTER = 1 << 0
BADGE_ICONS = 1 << 1
SOUNDS = 1 << 2
BANNER_STYLE = 1 << 3
ALERT_STYLE = 1 << 4
UNKNOWN_5 = 1 << 5
UNKNOWN_6 = 1 << 6
UNKNOWN_7 = 1 << 7
UNKNOWN_8 = 1 << 8
UNKNOWN_9 = 1 << 9
UNKNOWN_10 = 1 << 10
UNKNOWN_11 = 1 << 11
SUPPRESS_ON_LOCKSCREEN = 1 << 12
SHOW_PREVIEWS_ALWAYS = 1 << 13
SUPPRESS_MESSAGE_PREVIEWS = 1 << 14
UNKNOWN_15 = 1 << 15
ALLOW_NOTIFICATIONS = 1 << 25

BITS_TO_SET = DONT_SHOW_IN_CENTER | SUPPRESS_ON_LOCKSCREEN  # 0x1001

parser = argparse.ArgumentParser(
    description="Suppress lock screen and notification center entries for all installed apps."
)
parser.add_argument(
    "--dry-run",
    action="store_true",
    help="Preview changes without writing or restarting the daemon.",
)
args = parser.parse_args()

try:
    with open(PLIST, "rb") as f:
        data = plistlib.load(f)

    changed_count = 0
    for app in data["apps"]:
        src = app.get("src") or []
        path = app.get("path") or (src[0].get("path") if src else "") or ""
        if not os.path.exists(path):
            continue

        old_flags = app["flags"]
        new_flags = old_flags | BITS_TO_SET

        if new_flags != old_flags:
            if args.dry_run:
                print(f"{path}  [flags: {old_flags} → {new_flags}]  would update")
            else:
                app["flags"] = new_flags
                print(f"{path}  [flags: {old_flags} → {new_flags}]  ✓ updated")
            changed_count += 1

    if args.dry_run:
        print(f"\n{changed_count} app(s) would be updated.")
    else:
        if changed_count > 0:
            tmp_path = PLIST + ".tmp"
            with open(tmp_path, "wb") as f:
                plistlib.dump(data, f, fmt=plistlib.FMT_BINARY)
            os.replace(tmp_path, PLIST)
            print(
                f"\n{changed_count} app(s) updated. Restarting notificationcenterui..."
            )
            subprocess.run(["killall", "notificationcenterui"], check=False)
        else:
            print("All apps already have the required flags set.")

except PermissionError:
    print(
        f"error: permission denied reading/writing {PLIST}\n\n"
        "Grant Full Disk Access to your terminal app:\n"
        "  System Settings → Privacy & Security → Full Disk Access",
        file=sys.stderr,
    )
    sys.exit(1)
