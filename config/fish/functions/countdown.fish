function countdown
    test -z "$argv[1]"; and set argv[1] 0
    set -l start "$(math "$(date +%s) + $argv[1]")"
    while [ "$start" -ge $(date +%s) ]
        ## Is this more than 24h away?
        set -l days "$(math "floor(($start - $(date +%s)) / 86400)")"
        set -l time "$(math "$start - $(date +%s)")"
        printf '%s day(s) and %s\r' "$days" "$(date -u -d "@$time" +%H:%M:%S)"
        sleep 0.1
    end
end
