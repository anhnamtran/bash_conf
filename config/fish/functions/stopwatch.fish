function stopwatch
    set -l start $(date +%s)
    while true;
        set -l days "$(math "floor(($(date +%s) - $start) / 86400)")"
        set -l time "$(math "$(date +%s) - $start")"
        printf '%s day(s) and %s\r' "$days" "$(date -u -d "@$time" +%H:%M:%S)"
        sleep 0.1
    end
end
