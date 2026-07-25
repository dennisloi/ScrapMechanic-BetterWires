export STEAM_PATH=~/.steam
dest=$STEAM_PATH/steam/steamapps/common/Scrap\ Mechanic

cd Alternative/NotConnectedBearing/Data/

find . -type f -print0 |
  while IFS= read -r -d '' file; do

    #Strip the ./
    relative="${file#./}"

    #Build the target path
    target="$dest/Data/$relative"

    #Copying
    echo "Copying $file -> $target"
    cp "$file" "$target"

    #Remove cache entry
    echo "Removing cache entry for $(basename "${relative%.*}"):"
    find "$dest/Cache" -type f -name "$(basename "${relative%.*}")*" -print -delete

  done
