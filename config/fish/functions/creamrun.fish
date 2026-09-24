function creamrun
   CREAM=1 CCACHE_DISABLE=1 CREAM_MEMORY_LIMIT="max" \
      a ws make -f "$argv" product
end
