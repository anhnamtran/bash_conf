set -l A4C_PS (a4c ps | tail -n +2)

for line in $A4C_PS
   set -l nickname (echo $line | awk '{ print $1 }')
   set -l project (echo $line | awk '{ print $2 }')
   set -l changenum (echo $line | awk '{ print $3 }')
   set -l rebase_cache (echo $line | awk '{ print $5 }')

   complete -x -c ash -a "$nickname" -d "$project@$changenum, $rebase_cache"
end
