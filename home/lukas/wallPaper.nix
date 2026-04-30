{ pkgs }:

pkgs.writeShellScriptBin "newWallpaper" ''
  set -e

  # 1. Setup paths (using home directory instead of root /wallpapers)
  MARKET="en-US"
  OUTPUT_DIR="$HOME/Pictures/Wallpapers/Bing"
  mkdir -p "$OUTPUT_DIR"

  # 2. Fetch metadata
  API_URL="https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=$MARKET"
  JSON=$(${pkgs.curl}/bin/curl -s "$API_URL")

  # 3. Extract path and ID
  IMG_PATH=$(echo "$JSON" | ${pkgs.jq}/bin/jq -r '.images[0].url')
  # Extract the ID (everything between id= and the next &)
  ORIGINAL_FILENAME=$(echo "$IMG_PATH" | ${pkgs.gnused}/bin/sed -n 's/.*[?&]id=\([^&]*\).*/\1/p')

  # 4. Construct the UHD Filename/URL
  # Swaps _1920x1080 (or similar) with _UHD
  UHD_FILENAME=$(echo "$ORIGINAL_FILENAME" | ${pkgs.gnused}/bin/sed 's/_[0-9]*x[0-9]*\.jpg$/_UHD.jpg/')
  UHD_URL="https://www.bing.com/th?id=''${UHD_FILENAME}&uhd=1&uhdwidth=3840&uhdheight=2160"

  TARGET_FILE="$OUTPUT_DIR/$UHD_FILENAME"

  # 5. Download only if we don't have it
  if [ ! -f "$TARGET_FILE" ]; then
      echo "Downloading 4K Wallpaper: $UHD_FILENAME"
      ${pkgs.curl}/bin/curl -L -s -o "$TARGET_FILE" "$UHD_URL"
  else
      echo "Wallpaper already exists, skipping download."
  fi

  # 6. Set the wallpaper (Linking to 'latest' helps for some configs)
  ln -sf "$TARGET_FILE" "$OUTPUT_DIR/latest.jpg"
  ${pkgs.awww}/bin/awww img "$TARGET_FILE"
''
