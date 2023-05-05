function restart_easyeffects -d "Quickly restart easyeffects"
  pgrep -x easyeffects | xargs kill -9
  easyeffects --gapplication-service &>/dev/null & disown
end
