local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT='$(printf %40s |tr " " "_")
%{$fg[cyan]%}%~%{$reset_color%} $(git_prompt_info)
${ret_status} '

ZSH_THEME_GIT_PROMPT_PREFIX="[git:"
ZSH_THEME_GIT_PROMPT_SUFFIX="]$reset_color"
ZSH_THEME_GIT_PROMPT_DIRTY="$fg[red]+"
ZSH_THEME_GIT_PROMPT_CLEAN="$fg[green]"

function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}
