function nopdb
  if set -q NOPDB
     set -e NOPDB
  else
     set -gx NOPDB 1
  end
  echo "NOPDB=$NOPDB"
end
