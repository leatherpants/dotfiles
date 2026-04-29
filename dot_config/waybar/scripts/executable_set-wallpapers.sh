#!/usr/bin/env bash

MATUGEN_CACHE_DIR="$HOME/.cache/matugen"
mkdir -p "$MATUGEN_CACHE_DIR"

#########################################################################
### 设定壁纸 ###

echo "--------1. 选择壁纸--------"
# 1. 获取所有连接的显示器名称
# 使用 hyprctl 获取显示器列表
monitors=$(hyprctl monitors | grep "Monitor" | awk '{print $2}')
main_monitor=$(hyprctl monitors | grep "Monitor" -B 1 | grep "Monitor" | head -n 1 | awk '{print $2}')

# 检查是否获取到显示器
if [ -z "$monitors" ]; then
    echo "未检测到显示器，请确保你在 Hyprland 环境中。"
    exit 1
fi

# 准备保存路径的关联数组
declare -A wallpaper_paths

# 2. 为每台显示器选择壁纸
for monitor in $monitors; do
    title="为显示器 $monitor 选择壁纸"
    [ "$monitor" == "$main_monitor" ] && title="$title (主显示器)"
    
    # 弹出 yad 文件选择器
    selected=$(yad --file --text="$title" --image-filter="*.jpg *.png *.webp")
    
    if [ -n "$selected" ]; then
        echo "为 $monitor 选择了壁纸: $selected"
        wallpaper_paths[$monitor]=$selected
    else
        echo "用户取消了为 $monitor 选择壁纸，退出脚本。"
        exit 0
    fi
done

# 3. 保存主显示器壁纸
main_wallpaper="${wallpaper_paths[$main_monitor]}"

#########################################################################
### 使用 matugen 生成色板 ###

echo "--------2. 选择色彩风格--------"

NEW_MATUGEN_COLOR_SCHEME=$(yad --list --radiolist \
    --text="Matugen 配色方案选择" \
    --width=400 --height=500 \
    --column="选择" --column="方案名称" \
    FALSE "scheme-content" \
    FALSE "scheme-expressive" \
    FALSE "scheme-fidelity" \
    FALSE "scheme-fruit-salad" \
    FALSE "scheme-monochrome" \
    FALSE "scheme-neutral" \
    FALSE "scheme-rainbow" \
    TRUE  "scheme-tonal-spot" \
    FALSE "scheme-vibrant" \
    --print-column=2 --separator="")

# 检查用户是否点击了取消
if [ -z "$NEW_MATUGEN_COLOR_SCHEME" ]; then
    echo "未选择任何方案，退出。"
    exit 1
fi

echo "你选择的方案是: $NEW_MATUGEN_COLOR_SCHEME"

# 获取 darkman 的当前模式 (会返回 "light" 或 "dark")
current_mode=$(darkman get)

# 如果 darkman 获取失败，默认使用 dark
[ -z "$current_mode" ] && current_mode="dark"

echo "当前模式: $current_mode"

##########################################################################
### 总结并确认设置 ###

summary="你选择的壁纸和配色方案如下：\n\n"
for monitor in $monitors; do
    ismain=""
    [ "$monitor" == "$main_monitor" ] && ismain="（主显示器）"
    summary+="显示器: $monitor$ismain, 壁纸: ${wallpaper_paths[$monitor]}\n"
done
summary+="\nMatugen 配色方案: $NEW_MATUGEN_COLOR_SCHEME\n"
summary+="当前模式: $current_mode\n\n"
summary+="是否继续？"
yad --question \
    --text="$summary" \
    --width=400 --height=300

if [ $? -ne 0 ]; then
    echo "用户取消了操作，退出脚本。"
    sleep 3
    exit 0
fi

##########################################################################
### 应用设置 ###

echo "--------3. 应用设置--------"

# 1. 使用 hyprpaper 设定壁纸并写入配置文件
echo "splash = true" > "$HOME/.config/hypr/hyprpaper.conf"

for monitor in "${!wallpaper_paths[@]}"; do
    path="${wallpaper_paths[$monitor]}"
    hyprctl hyprpaper wallpaper "$monitor,$path"
    cat <<EOF >> "$HOME/.config/hypr/hyprpaper.conf"
wallpaper {
    monitor = $monitor
    path = $path
    fit_mode = cover
}
EOF
done

echo "所有显示器的壁纸已设置完成！"

# 2. 使用 matugen 生成色板并写入配置文件
matugen_json=$( matugen image "$main_wallpaper" --type "$NEW_MATUGEN_COLOR_SCHEME" --mode "$current_mode" --json hsl --source-color-index 0)

echo "" > "$MATUGEN_CACHE_DIR/config.env"
echo "WALLPAPER=\"$main_wallpaper\"" >> "$MATUGEN_CACHE_DIR/config.env"
echo "MATUGEN_COLOR_SCHEME=\"$NEW_MATUGEN_COLOR_SCHEME\"" >> "$MATUGEN_CACHE_DIR/config.env"

echo "色板生成完成！"


# 3. 根据matugen色板设置 Tela Circle 图标主题颜色
hue=$(echo "$matugen_json" | grep -A 3 \"primary\" | grep light | grep -Eo [0-9]+ | head -n 1)
# 映射 Hue 到 Tela Circle 颜色区间
# 映射逻辑基于 Tela-circle 常见的 8 种颜色变体
if (( hue >= 345 || hue < 15 ));  then icon_color="red"
elif (( hue >= 15  && hue < 45 ));  then icon_color="orange"
elif (( hue >= 45  && hue < 75 ));  then icon_color="yellow"
elif (( hue >= 75  && hue < 155 )); then icon_color="green"
elif (( hue >= 155 && hue < 195 )); then icon_color="manjaro" # 对应 Cyan/Teal
elif (( hue >= 195 && hue < 265 )); then icon_color="blue"
elif (( hue >= 265 && hue < 300 )); then icon_color="purple"
else icon_color="pink"
fi
# Set icon theme via gsettings
gsettings set org.gnome.desktop.interface icon-theme "Tela-circle-$icon_color-$current_mode"

echo "图标主题颜色已设置完成！"

echo "--------所有任务完成！窗口将自动关闭！--------"
sleep 3
exit
