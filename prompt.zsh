
# http://qiita.com/takc923/items/c479e38112b913b7614a


function current_branch() {
    local ref
    ref=$(\git symbolic-ref --quiet HEAD 2> /dev/null)
    local ret=$?
    if [[ $ret != 0 ]]
    then
        [[ $ret = 128 ]] && return
        ref=$(\git rev-parse --short HEAD 2> /dev/null) || return
    fi
    echo ${ref#refs/heads/}
}

function git_prompt_status () {                                                                                                                                                                                                                       local INDEX STATUS
        INDEX=$(\git status --porcelain -b 2> /dev/null)
        STATUS=""
        if $(echo "$INDEX" | \grep -E '^\?\? ' &> /dev/null)
        then
                STATUS="$ZSH_THEME_GIT_PROMPT_UNTRACKED$STATUS"
        fi
        if $(echo "$INDEX" | \grep '^A ' &> /dev/null)
        then
                STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
        elif $(echo "$INDEX" | \grep '^M ' &> /dev/null)
        then
                STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
        fi
        if $(echo "$INDEX" | \grep '^ M ' &> /dev/null)
        then
                STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
        elif $(echo "$INDEX" | \grep '^AM ' &> /dev/null)
        then
                STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
        elif $(echo "$INDEX" | \grep '^ T ' &> /dev/null)
        then
                STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
        fi
        if $(echo "$INDEX" | \grep '^R  ' &> /dev/null)
        then
                STATUS="$ZSH_THEME_GIT_PROMPT_RENAMED$STATUS"
        fi
        if $(echo "$INDEX" | \grep '^ D ' &> /dev/null)
        then
                STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
        elif $(echo "$INDEX" | \grep '^D  ' &> /dev/null)
        then
                STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
        elif $(echo "$INDEX" | \grep '^AD ' &> /dev/null)
        then
                STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
        fi
        if $(\git rev-parse --verify refs/stash >/dev/null 2>&1)
        then
                STATUS="$ZSH_THEME_GIT_PROMPT_STASHED$STATUS"
        fi
        if $(echo "$INDEX" | \grep '^UU ' &> /dev/null)
        then
                STATUS="$ZSH_THEME_GIT_PROMPT_UNMERGED$STATUS"
        fi
        if $(echo "$INDEX" | \grep '^## [^ ]\+ .*ahead' &> /dev/null)
        then
                STATUS="$ZSH_THEME_GIT_PROMPT_AHEAD$STATUS"
        fi
        if $(echo "$INDEX" | \grep '^## [^ ]\+ .*behind' &> /dev/null)
        then
                STATUS="$ZSH_THEME_GIT_PROMPT_BEHIND$STATUS"
        fi
        if $(echo "$INDEX" | \grep '^## [^ ]\+ .*diverged' &> /dev/null)
        then
                STATUS="$ZSH_THEME_GIT_PROMPT_DIVERGED$STATUS"
        fi
        echo $STATUS
}

local reset_color="\e[m"
local -A fg
fg=(black "\e[30m" red "\e[31m" green "\e[32m" yellow "\e[33m" blue "\e[1;34m" magenta "\e[35m" cyan "\e[36m" gray "\e[37m" white "\e[1:37m")

function str_with_color() {
    echo "%{$fg[$1]%}$2%{$reset_color%}"
}

ZSH_THEME_GIT_PROMPT_ADDED=$(str_with_color cyan '+')
ZSH_THEME_GIT_PROMPT_MODIFIED=$(str_with_color yellow '*')
ZSH_THEME_GIT_PROMPT_DELETED=$(str_with_color red 'x')
ZSH_THEME_GIT_PROMPT_RENAMED=$(str_with_color blue 'o')
ZSH_THEME_GIT_PROMPT_UNMERGED=$(str_with_color magenta '!')
ZSH_THEME_GIT_PROMPT_UNTRACKED=$(str_with_color grey '?')

function my_git_status() {
    [ $(current_branch) ] && echo "($(current_branch)$(git_prompt_status))"
}

DATE_TIME=$(str_with_color yellow '%D{%Y-%m-%d %K:%M}')
PROMPT_PREFIX=$(str_with_color white '#')
SEPARATOR1=$(str_with_color white '|')
USER_NAME=$(str_with_color blue '%n')
SEPARATOR2=$(str_with_color white '@')
HOST_NAME=$(str_with_color cyan '%m')
SEPARATOR3=$(str_with_color white ':')
CURRENT_DIRECTORY=$(str_with_color green '%~')
PROMPT_CHAR=$(str_with_color white '$ ')
PROMPT="${PROMPT_PREFIX}${DATE_TIME}${SEPARATOR1}${USER_NAME}${SEPARATOR2}${HOST_NAME}${SEPARATOR3}${CURRENT_DIRECTORY} $(my_git_status)
$PROMPT_CHAR"
PROMPT2=$(str_with_color white '> ')

