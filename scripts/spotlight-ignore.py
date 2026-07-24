#!/usr/bin/env python3
import subprocess
import sys
from pathlib import Path

SCAN_DIRS = ["~/Code"]
PATTERNS = {"node_modules"}
SPOTLIGHT_PREFPANE = "/System/Library/PreferencePanes/Spotlight.prefPane"


def find_top_level_matches():
    """Return top-level, still-indexed directories matching PATTERNS."""
    # sorted() keeps the generated query stable between runs so it can be
    # copy-pasted into mdfind when debugging.
    query = " || ".join(f'kMDItemFSName == "{p}"' for p in sorted(PATTERNS))
    raw_query = f'({query}) && kMDItemContentTypeTree == "public.folder"'
    matches = set()
    for scan_dir in SCAN_DIRS:
        root_path = Path(scan_dir).expanduser()
        if not root_path.is_dir():
            print(f"warning: scan dir does not exist: {root_path}", file=sys.stderr)
            continue
        result = subprocess.run(
            # -0 because newlines are legal in directory names.
            ["mdfind", "-0", "-onlyin", root_path, raw_query],
            capture_output=True,
            text=True,
            check=False,
        )
        if result.returncode != 0:
            print(
                f"warning: mdfind failed for {root_path} "
                f"(exit {result.returncode}): {result.stderr.strip()}",
                file=sys.stderr,
            )
            continue
        # resolve() canonicalizes symlinks so the set dedups aliases of the same
        # target and the nesting check below stays reliable.
        matches.update(
            Path(entry).resolve() for entry in result.stdout.split("\0") if entry
        )

    # Sorting guarantees a parent sorts before its descendants, so checking each
    # path only against already-kept entries is enough to drop all nesting.
    deduped = []
    for path in sorted(matches):
        # Skip stale index entries for folders deleted since indexing.
        if not path.is_dir():
            continue
        if any(path.is_relative_to(parent) for parent in deduped):
            continue
        deduped.append(path)
    return deduped


def main():
    if sys.platform != "darwin":
        print("^ Skipped because platform is not macOS.")
        return

    paths = find_top_level_matches()
    if not paths:
        print("No matching directories found (or all are already excluded).")
        return

    print(f"Found {len(paths)} top-level director{'y' if len(paths) == 1 else 'ies'}:")
    for i, path in enumerate(paths, 1):
        print(f"  {i}. {path}")

    print("\nRevealing in Finder and opening Spotlight settings...")
    try:
        # A single call so one failure cannot leave the remaining folders
        # unrevealed after the earlier ones already opened.
        subprocess.run(["open", "-R", *paths], check=True)
        subprocess.run(["open", SPOTLIGHT_PREFPANE], check=True)
    except (subprocess.CalledProcessError, FileNotFoundError) as e:
        print(
            f"error: failed to reveal folders or open Spotlight settings: {e}\n\n"
            "Add the directories listed above to the Spotlight Privacy list "
            "manually:\n"
            "  System Settings → Spotlight → Search Privacy",
            file=sys.stderr,
        )
        sys.exit(1)


if __name__ == "__main__":
    main()
