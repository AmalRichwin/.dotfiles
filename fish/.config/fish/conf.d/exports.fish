# Load shared exports from ~/.exports (bash/zsh syntax, expanded via bash).
if test -f "$HOME/.exports"; and type -q bash
    bash -lc 'source "$HOME/.exports" 2>/dev/null; export -p' 2>/dev/null | while read -l line
        if not string match -qr '^declare -x ' $line
            continue
        end

        set -l assignment (string replace 'declare -x ' '' $line)
        set -l parts (string split -m1 '=' $assignment)
        set -l name $parts[1]
        set -l value $parts[2]
        set value (string trim -c '"' $value)
        set value (string trim -c "'" $value)
        set -gx $name $value
    end
end
