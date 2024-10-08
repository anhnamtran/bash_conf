function fish_right_prompt
  set -l kubePrompt (set_color --bold green)(__kube_prompt)(set_color normal)

  echo "$kubePrompt"
end
