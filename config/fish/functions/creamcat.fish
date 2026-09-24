function creamcat
  grep --color=auto "cpp" "$1" \
     | sed 's/.*\/\([^ ]*.cpp\).*| [0-9\.]* [0-9\.]* \([0-9]*\).*$/\2\t\1/'\
     | sort -n -k1
end
