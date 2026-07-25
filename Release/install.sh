#!/usr/bin/env bash

export STEAM_PATH="$HOME/.steam"
dest="$STEAM_PATH/steam/steamapps/common/Scrap Mechanic"

install_version() {
  local version="$1"
  local source_dir="$2"

  echo
  echo "Installing: $version"
  echo "Source: $source_dir"
  echo

  find "$source_dir" -type f -print0 |
    while IFS= read -r -d '' file; do

      # Strip the source directory prefix
      relative="${file#"$source_dir"/}"

      # Build target path
      target="$dest/Data/$relative"

      # Make sure the target directory exists
      mkdir -p "$(dirname "$target")"

      # Copy file
      echo "Copying $file -> $target"
      cp "$file" "$target"

      # Remove cache entry
      cache_name="$(basename "${relative%.*}")"
      echo "Removing cache entry for $cache_name:"
      find "$dest/Cache" \
        -type f \
        -name "$cache_name*" \
        -print \
        -delete

    done

  echo
  echo "$version installed."
}

while true; do
  echo
  echo "Choose a version to install:"
  echo "1) Default"
  echo "2) Alternaative wires"
  echo "3) Not Connected Bearing"
  echo "4) Small Bearings"
  echo "5) Small dot"
  echo "0) Exit"
  echo

  read -rp "Enter choice: " choice

  case "$choice" in
  1)
    install_version \
      "Default" \
      "Data"
    ;;

  2)
    install_version \
      "Alternative Wires"
    "Alternative/Alternative Wires/Data"
    ;;

  3)
    install_version \
      "Not Connected Bearing" \
      "Alternative/NotConnectedBearing/Data"
    ;;

  4)
    install_version \
      "Smaller Bearings" \
      "Alternative/Small Bearing/Data"
    ;;

  5)
    install_version \
      "Smaller Dot" \
      "Alternative/Smaller Dot/Data"
    ;;

  0)
    echo "Exiting."
    exit 0
    ;;

  *)
    echo "Invalid choice. Please enter 1, 2, or 0."
    ;;
  esac
done
