function restart_easyeffects -d "Quickly restart easyeffects"
  pgrep -x easyeffects | xargs kill -9
  easyeffects --service-mode &>/dev/null & disown
end
