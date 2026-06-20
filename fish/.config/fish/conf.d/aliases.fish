# Load alias lines from shared ~/.aliases (bash/zsh syntax).
if test -f "$HOME/.aliases"
    while read -l line
        set line (string trim $line)
        test -z "$line" && continue
        string match -qr '^#' $line && continue

        if string match -qr '^alias ' $line
            if string match -qr "^alias -- -=" $line
                alias -='cd -'
            else if string match -qr "^alias [^=]+='.*'$" $line
                set -l name (string replace -r "alias ([^=]+)='.*'" '$1' $line)
                set -l value (string replace -r "alias [^=]+='(.*)'" '$1' $line)
                alias $name $value
            else if string match -qr '^alias [^=]+=".*"$' $line
                set -l name (string replace -r 'alias ([^=]+)=".*"' '$1' $line)
                set -l value (string replace -r 'alias [^=]+="(.*)"' '$1' $line)
                alias $name $value
            end
        end
    end < "$HOME/.aliases"
end

# Git diagnostics — fish functions (logic mirrors ~/.aliases)
if type -q git
    function git-churn --argument since
        if test -z "$since"
            set since "1 year ago"
        end
        git log --format=format: --name-only --since="$since" \
            | sort | uniq -c | sort -nr | head -20
    end

    function git-authors
        git shortlog -sn --no-merges $argv
    end

    function git-authors-recent --argument since
        if test -z "$since"
            set since "6 months ago"
        end
        git shortlog -sn --no-merges --since="$since"
    end

    function git-bugspots
        git log -i -E --grep="fix|bug|broken" --name-only --format='' \
            | sort | uniq -c | sort -nr | head -20
    end

    function git-velocity
        git log --format='%ad' --date=format:'%Y-%m' | sort | uniq -c
    end

    function git-firefight --argument since
        if test -z "$since"
            set since "1 year ago"
        end
        if type -q rg
            git log --oneline --since="$since" | rg -i 'revert|hotfix|emergency|rollback'
        else
            git log --oneline --since="$since" | grep -iE 'revert|hotfix|emergency|rollback'
        end
    end

    function git-audit --argument since
        if test -z "$since"
            set since "1 year ago"
        end

        echo "== Top changed files (since $since) =="
        git-churn $since
        echo

        echo "== All contributors =="
        git-authors
        echo

        echo "== Contributors (last 6 months) =="
        git-authors-recent
        echo

        echo "== Bug hotspot files =="
        git-bugspots
        echo

        echo "== Commit velocity by month =="
        git-velocity
        echo

        echo "== Reverts / hotfixes (since $since) =="
        git-firefight $since
    end
end
