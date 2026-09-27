#!/bin/bash
set -e

FLUTTER_VERSION="3.27.4"
FLUTTER_ARCHIVE="flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"
FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/${FLUTTER_ARCHIVE}"

if [ ! -d "$HOME/flutter" ]; then
  curl -sSL "$FLUTTER_URL" -o "/tmp/${FLUTTER_ARCHIVE}"
  tar -xf "/tmp/${FLUTTER_ARCHIVE}" -C "$HOME"
  rm "/tmp/${FLUTTER_ARCHIVE}"
fi
export PATH="$PATH:$HOME/flutter/bin"

flutter doctor
flutter pub get
flutter build web --release \
  --dart-define=SUPABASE_URL="$SUPABASE_URL" \
  --dart-define=SUPABASE_ANON_KEY="$SUPABASE_ANON_KEY"
