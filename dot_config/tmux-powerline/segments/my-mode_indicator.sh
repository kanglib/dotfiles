# Indicator of pressing TMUX prefix.

prefix_pressed_text="^A"
normal_mode_text="  "

run_segment() {
        prefix_indicator="#{?client_prefix,${prefix_pressed_text},${normal_mode_text}}"
        echo "$prefix_indicator"
        return 0
}
