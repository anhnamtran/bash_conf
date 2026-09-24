function color_kw
   GREP_COLORS="ne:$1" grep --color=always -e"$2" -e^
end
