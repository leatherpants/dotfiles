#!/usr/bin/env bash

# Directory for wallpapers
WALL_DIR="$HOME/Pictures/wallpapers"

# 1. Get available monitors without jq
MONITORS=$(hyprctl monitors | grep "Monitor" | awk '{print $2}')
declare -A SELECTED_WALLS

echo "--- Wallpaper Selection ---"

# Get full paths of files
mapfile -t FULL_PATHS < <(find "$WALL_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \))

# Create a list of just the filenames for display
FILE_NAMES=()
for path in "${FULL_PATHS[@]}"; do
    FILE_NAMES+=("$(basename "$path")")
done

if [ ${#FILE_NAMES[@]} -eq 0 ]; then
    echo "No wallpapers found in $WALL_DIR"
    exit 1
fi

# Ask user to select wallpapers for each detected monitor
for mon in $MONITORS; do
    echo -e "\nSelect wallpaper for monitor: $mon"
    
    # Use the FILE_NAMES array for the display list
    select filename in "${FILE_NAMES[@]}"; do
        if [ -n "$filename" ]; then
            # Find the index of the selected filename to get the corresponding full path
            for i in "${!FILE_NAMES[@]}"; do
               if [[ "${FILE_NAMES[$i]}" == "$filename" ]]; then
                   SELECTED_WALLS[$mon]="${FULL_PATHS[$i]}"
                   break
               fi
            done
            break
        else
            echo "Invalid selection. Please enter the number."
        fi
    done
done

# 2. Ask for Pywal theme type
echo -e "\n--- Pywal Theme ---"
echo "Select Pywal color mode:"
select p_mode in "Dark" "Light"; do
    case $p_mode in
        "Light") PY_FLAG="-l"; break ;;
        "Dark")  PY_FLAG=""; break ;;
        *) echo "Invalid selection." ;;
    esac
done

# 3. & 4. Icon Pack selection (Tela Circle)
echo -e "\n--- Tela Circle Icon Theme ---"
colors=("standard" "black" "blue" "brown" "dracula" "green" "grey" "manjaro" "nord" "orange" "pink" "purple" "red" "ubuntu" "yellow")
echo "Choose a color variant:"
select color in "${colors[@]}"; do
    [[ -n "$color" ]] && break || echo "Invalid selection."
done

echo "Choose icon version (light/dark):"
select i_ver in "light" "dark"; do
    [[ -n "$i_ver" ]] && break || echo "Invalid selection."
done

# Construct Icon Theme Name
if [ "$color" == "standard" ]; then
    FINAL_ICON="Tela-circle-$i_ver"
else
    FINAL_ICON="Tela-circle-$color-$i_ver"
fi

# 5. Apply wallpapers via hyprpaper IPC
echo -e "\nApplying wallpapers via Hyprpaper..."
for mon in "${!SELECTED_WALLS[@]}"; do
    wall_path="${SELECTED_WALLS[$mon]}"
    hyprctl hyprpaper wallpaper "$mon,$wall_path"
done

# 6. Set icon theme via gsettings
echo "Setting icon theme to $FINAL_ICON..."
gsettings set org.gnome.desktop.interface icon-theme "$FINAL_ICON"

# 7. Apply Pywal based on the first monitor's wallpaper
FIRST_MON=$(echo "$MONITORS" | head -n 1)
FIRST_WALL="${SELECTED_WALLS[$FIRST_MON]}"

echo "Generating Pywal theme from $(basename "$FIRST_WALL")..."
wal -i "$FIRST_WALL" $PY_FLAG

echo -e "\nConfiguration Complete!"
