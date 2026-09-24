function fish_jj_prompt
    # If jj isn't installed, there's nothing we can do
    # Return 1 so the calling prompt can deal with it
    if not command -sq jj
        return 1
    end

    # Walk up to find .jj/ repo root; check for disable file (no subprocess)
    set -l d $PWD
    while test -n "$d"
        if test -d "$d/.jj"
            test -f "$d/.disable-jj-prompt"; and return 1
            break
        end
        set d (string replace -r '/[^/]*$' '' -- $d)
    end

    # All jj queries use --color=never. Colors are applied in fish.
    #
    # Main query outputs structured plain text:
    #   @ line:       change_id \t author \t bookmarks_or_dot \t tags_or_dot \t working_copies \t commit_id \t status \t immutable \t description
    #   ancestor:     change_id \t bookmarks_or_dot \t tags_or_dot
    #   ancestor:     .                       (if not bookmarked)
    #   behind:       B
    #
    # Ahead = total line count (excluding B lines).
    # Bookmark depth = |bookmark::@ ~ bookmark| via sub-query.
    set -l tmpl '
if(self.contained_in("::trunk() & ~::@"),
    "B\n",
    if(self.contained_in("@"),
        change_id.shortest() ++
            if(divergent, "/" ++ change_offset) ++
        "\t" ++
        if(self.contained_in("mine()"), ".", coalesce(author.email().local(), author.name(), ".")) ++
        "\t" ++
        coalesce(if(local_bookmarks, local_bookmarks.join(",")), ".") ++ "\t" ++
        coalesce(if(tags, tags.join(",")), ".") ++ "\t" ++
        working_copies ++ "\t" ++
        commit_id.shortest() ++ "\t" ++
        separate(" ",
            if(conflict, "(conflict)"),
            if(divergent, "(divergent)"),
            if(hidden, "(hidden)"),
            coalesce(
                if(empty, "(empty)"),
                "*",
            ),
        ) ++ "\t" ++
        immutable ++ "\t" ++
        if(description, description.first_line(), "(no description set)") ++ "\n"
    ,
        if(self.contained_in("trunk()"),
            ".\n",
            if(local_bookmarks,
                change_id.shortest() ++ "\t" ++ local_bookmarks.join(",") ++ "\t" ++ coalesce(if(tags, tags.join(",")), ".") ++ "\n",
                if(tags,
                    change_id.shortest() ++ "\t.\t" ++ tags.join(",") ++ "\n",
                    ".\n",
                )
            )
        )
    )
)
'
    set -l raw_lines (jj log --no-pager --no-graph --ignore-working-copy --color=never \
        -r '@ | trunk()..@ | (::trunk() & ~::@)' \
        -T $tmpl 2>/dev/null)
    or return 1

    # Colors
    set -l bold_brmagenta (set_color brmagenta)
    set -l bold_brblue (set_color brblue)
    set -l reset (printf '\e[39m')

    # Mirror fish_git_prompt's public styling variables.
    set -l branch_color yellow
    set -q __fish_git_prompt_color_branch
    and set branch_color $__fish_git_prompt_color_branch
    set -l branch_color_code (set_color $branch_color)

    set -l dirty_color blue
    set -q __fish_git_prompt_color_dirtystate
    and set dirty_color $__fish_git_prompt_color_dirtystate
    set -l dirty_color_code (set_color $dirty_color)

    set -l clean_color green
    set -q __fish_git_prompt_color_cleanstate
    and set clean_color $__fish_git_prompt_color_cleanstate
    set -l clean_color_code (set_color $clean_color)

    set -l invalid_color red
    set -q __fish_git_prompt_color_invalidstate
    and set invalid_color $__fish_git_prompt_color_invalidstate
    set -l invalid_color_code (set_color $invalid_color)

    set -l upstream_color brblack
    set -q __fish_git_prompt_color_upstream
    and set upstream_color $__fish_git_prompt_color_upstream
    set -l upstream_color_code (set_color $upstream_color)

    set -l state_separator " "
    set -q __fish_git_prompt_char_stateseparator
    and set state_separator $__fish_git_prompt_char_stateseparator
    set -l upstream_ahead " "
    set -q __fish_git_prompt_char_upstream_ahead
    and set upstream_ahead $__fish_git_prompt_char_upstream_ahead
    set -l upstream_behind " "
    set -q __fish_git_prompt_char_upstream_behind
    and set upstream_behind $__fish_git_prompt_char_upstream_behind
    set -l upstream_diverged "󱀝"
    set -q __fish_git_prompt_char_upstream_diverged
    and set upstream_diverged $__fish_git_prompt_char_upstream_diverged
    set -l dirty_icon "󰐕 "
    set -q __fish_git_prompt_char_dirtystate
    and set dirty_icon $__fish_git_prompt_char_dirtystate
    set -l clean_icon " "
    set -q __fish_git_prompt_char_cleanstate
    and set clean_icon $__fish_git_prompt_char_cleanstate
    set -l invalid_icon " "
    set -q __fish_git_prompt_char_invalidstate
    and set invalid_icon $__fish_git_prompt_char_invalidstate

    set -l use_bold true
    set -q fish_jj_prompt_bold; and set use_bold $fish_jj_prompt_bold
    set -l bold ""
    test "$use_bold" = true; and set bold (printf '\e[1m')

    set -l info ""
    set -l has_conflict 0
    set -l has_immutable 0
    set -l behind 0
    set -l ahead 0
    set -l display_bookmarks
    # whether or not to show tags in the prompt (configurable via fish_jj_prompt_show_tags)
    set -l show_tags true
    set -q fish_jj_prompt_show_tags; and set show_tags $fish_jj_prompt_show_tags

    # whether or not to show other author in prompt (configurable via fish_jj_prompt_show_other_authors)
    set -l show_author true
    set -q fish_jj_prompt_show_other_authors; and set show_author $fish_jj_prompt_show_other_authors

    for line in $raw_lines
        if test "$line" = B
            set behind (math $behind + 1)
            continue
        end

        set ahead (math $ahead + 1)
        set -l parts (string split \t -- $line)
        set -l nparts (count $parts)

        if test $nparts -ge 9
            # @ line fields: change_id[1] author[2] bookmarks[3] tags[4] working_copies[5] commit_id[6] status[7] immutable[8] description[9]
            # Separate (divergent) from other status flags for distinct coloring
            set -l st $parts[7]
            set -l divergent_label ""
            set -l cid_color $bold_brmagenta
            if string match -q '*(divergent)*' -- "$st"
                set divergent_label " $invalid_color_code$upstream_diverged (divergent)$reset"
                set cid_color $invalid_color_code
                set st (string replace ' (divergent)' '' -- $st)
                set st (string replace '(divergent) ' '' -- $st)
                set st (string replace '(divergent)' '' -- $st)
            end
            set -l conflict_label ""
            if string match -q '*(conflict)*' -- "$st"
                set has_conflict 1
                set conflict_label " $invalid_color_code$invalid_icon(conflict)$reset"
                set st (string replace ' (conflict)' '' -- $st)
                set st (string replace '(conflict) ' '' -- $st)
                set st (string replace '(conflict)' '' -- $st)
            end
            set -l status_color $clean_color_code
            set -l status_label "$clean_icon$st"
            if test -n "$conflict_label"; or test -n "$divergent_label"
                set status_color $invalid_color_code
                set status_label ""
            else if test "$st" = "*"
                set status_color $dirty_color_code
                set status_label "$dirty_icon$st"
            else if test "$st" != "(empty)"
                set status_label $st
            end
            if test "$parts[8]" = true
                set has_immutable 1
            end
            # Author (only shown if not mine)
            set -l author_label ""
            if test "$parts[2]" != "."; and test "$show_author" = true
                set -l author_color (printf '\e[38;5;3m')
                set author_label " $author_color$parts[2]$reset"
            end
            set -l at_labels
            if test "$parts[3]" != "."
                for bookmark in (string split ',' -- $parts[3])
                    set bookmark (string trim -- $bookmark)
                    if test -n "$bookmark"
                        set -a at_labels "$branch_color_code$bookmark$reset"
                    end
                end
            end
            if test "$show_tags" = true; and test "$parts[4]" != "."
                for tag in (string split ',' -- $parts[4])
                    set tag (string trim -- $tag)
                    if test -n "$tag"
                        set -a at_labels "$bold_brmagenta$tag$reset"
                    end
                end
            end
            set -l at_bookmarks ""
            if test (count $at_labels) -gt 0
                set at_bookmarks " "(string join ' ' $at_labels)
            end
            # Show workspace if multiple workspaces exist
            set -l workspace_label ""
            set -l wc_count (jj workspace list --no-pager --color=never --ignore-working-copy 2>/dev/null | count)
            if test $wc_count -gt 1; and test -n "$parts[5]"
                set -l bold_brgreen_color (set_color brgreen)
                set workspace_label " $bold_brgreen_color$parts[5]$reset"
            end
            # Description (configurable via fish_jj_prompt_show_description and fish_jj_prompt_description_length)
            set -l show_desc true
            set -q fish_jj_prompt_show_description; and set show_desc $fish_jj_prompt_show_description
            set -l desc_length 24
            set -q fish_jj_prompt_description_length; and set desc_length $fish_jj_prompt_description_length
            set -l desc_label ""
            if test -n "$parts[9]"; and test "$show_desc" = true
                set -l desc $parts[9]
                if test $desc_length -gt 0; and test (string length -- $desc) -gt $desc_length
                    set desc (string sub -l $desc_length -- $desc)"…"
                end
                if test "$parts[9]" = "(no description set)"
                    set desc_label " $status_color$desc$reset"
                else
                    set desc_label " $desc"
                end
            end
            set info "$cid_color$parts[1]$reset$author_label$at_bookmarks$workspace_label $bold_brblue$parts[6]$reset$conflict_label$state_separator$status_color$status_label$reset$divergent_label$desc_label"
        else if test $nparts -eq 3
            set -l cid $parts[1]
            set -l depth_commits (jj log --no-pager --no-graph --ignore-working-copy --color=never \
                -r "$cid::@ ~ $cid" -T '".\n"' 2>/dev/null)
            set -l depth (count $depth_commits)
            for label_field in 2 3
                if test $label_field -eq 3; and test "$show_tags" != true
                    continue
                end
                if test "$parts[$label_field]" = "."
                    continue
                end
                for bookmark in (string split ',' -- $parts[$label_field])
                    set bookmark (string trim -- $bookmark)
                    if test -n "$bookmark"
                        set -l nobold (printf '\e[22m')
                        set -a display_bookmarks "$branch_color_code$bookmark$reset$nobold $upstream_color_code$upstream_ahead$depth$reset$bold"
                    end
                end
            end
        end
        # "." lines (nparts=1, not "B") just count toward ahead
    end

    # Assemble prompt
    if test -n "$info"
        if test (count $display_bookmarks) -gt 0
            set info "$info "(string join ' ' $display_bookmarks)
        end
        set -l nobold (printf '\e[22m')
        if test $ahead -gt 0
            set info "$info $nobold$upstream_color_code$upstream_ahead$ahead$reset"
        end
        if test $behind -gt 0
            set info "$info $nobold$upstream_color_code$upstream_behind$behind$reset"
        end
        set -l at_color $clean_color_code
        if test $has_conflict -eq 1
            set at_color $invalid_color_code
        else if test $has_immutable -eq 1
            set at_color (printf '\e[38;5;14m')
        end
        set -l full_reset (set_color normal)
        printf '(%s%s%s%s%s)' "$bold" "$at_color" @ "$reset $info" "$full_reset"
    end
end
