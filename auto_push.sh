#!/bin/bash

while true
do
  # Pull dengan output disembunyikan
  git pull --rebase > /dev/null 2>&1

  # Ambil daftar file yang berubah
  CHANGED=$(git diff --name-only)

  if [ ! -z "$CHANGED" ]; then
    git add . > /dev/null 2>&1
    git commit -m "auto commit $(date)" > /dev/null 2>&1
    git push > /dev/null 2>&1

    # Print bersih
    for FILE in $CHANGED; do
      echo "file $FILE berhasil di push"
    done
  else
    # Tidak ada commit baru, tetap push sisa rebase tapi diam
    git push > /dev/null 2>&1
  fi

  sleep 10
done