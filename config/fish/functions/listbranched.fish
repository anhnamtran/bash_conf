function listbranched
  a pj show memberPackages --json \
    | jq '.memberPackages | .[]' \
    | sed 's|^"\([^/]\+\)/.*$|\1|' \
    | tr '\n' ' '
end
