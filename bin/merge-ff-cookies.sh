#!/usr/bin/env bash
# merge-ff-cookies.sh — merge Firefox cookies from one profile into another
# Usage: ./merge-ff-cookies.sh <source-profile-dir> <dest-profile-dir>

set -euo pipefail

# ── Helpers ──────────────────────────────────────────────────────────────────
die()  { echo "ERROR: $*" >&2; exit 1; }
info() { echo "  --> $*"; }

# ── Usage ─────────────────────────────────────────────────────────────────────
if [[ $# -ne 2 ]]; then
  echo "Usage: $(basename "$0") <source-profile-dir> <dest-profile-dir>"
  echo
  echo "Example:"
  echo "  $(basename "$0") ~/.mozilla/firefox/a1b2c3d4.default-release \\"
  echo "                   ~/.mozilla/firefox/z9y8x7w6.work-profile"
  exit 1
fi

SRC_DIR="${1%/}"   # strip trailing slash if any
DST_DIR="${2%/}"

SRC_DB="$SRC_DIR/cookies.sqlite"
DST_DB="$DST_DIR/cookies.sqlite"

# ── Pre-flight checks ─────────────────────────────────────────────────────────
[[ -d "$SRC_DIR" ]] || die "Source profile directory not found: $SRC_DIR"
[[ -d "$DST_DIR" ]] || die "Destination profile directory not found: $DST_DIR"
[[ -f "$SRC_DB"  ]] || die "Source cookies.sqlite not found: $SRC_DB"
[[ -f "$DST_DB"  ]] || die "Destination cookies.sqlite not found: $DST_DB"

command -v sqlite3 &>/dev/null || die "'sqlite3' not found. Install it with: sudo pacman -S sqlite"

if pgrep -x firefox &>/dev/null; then
  die "Firefox is currently running. Close it completely before merging cookies."
fi

# ── WAL checkpoint on source (flush any pending writes) ───────────────────────
info "Checkpointing source database WAL..."
sqlite3 "$SRC_DB" "PRAGMA wal_checkpoint(FULL);" &>/dev/null || true

# ── Backup destination ────────────────────────────────────────────────────────
BACKUP="$DST_DB.bak.$(date +%Y%m%d_%H%M%S)"
info "Backing up destination cookies to: $BACKUP"
cp "$DST_DB" "$BACKUP"

# ── Merge ─────────────────────────────────────────────────────────────────────
info "Merging cookies from:"
info "  SRC: $SRC_DB"
info "  DST: $DST_DB"

# Count before
BEFORE=$(sqlite3 "$DST_DB" "SELECT COUNT(*) FROM moz_cookies;")

sqlite3 "$DST_DB" \
  "ATTACH '$SRC_DB' AS src;
   INSERT OR IGNORE INTO moz_cookies SELECT * FROM src.moz_cookies;
   DETACH src;"

# Count after
AFTER=$(sqlite3 "$DST_DB" "SELECT COUNT(*) FROM moz_cookies;")
ADDED=$(( AFTER - BEFORE ))

info "Done. Cookies before: $BEFORE | after: $AFTER | added: $ADDED"
info "Backup kept at: $BACKUP"
