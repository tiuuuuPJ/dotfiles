# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename $HOME/.zshrc

#### General settings
### History
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=100000

### Environment variables
export LANG=en_US.UTF-8
export XDG_CONFIG_HOME=$HOME/.config

### Options
setopt nocorrect #disable spell correction
setopt list_packed
setopt nolistbeep
setopt auto_cd
setopt auto_menu
setopt auto_param_slash
setopt mark_dirs
setopt list_types
setopt complete_in_word
setopt ignoreeof

setopt hist_ignore_dups #ignore duplicates in history
setopt share_history
setopt extended_history
setopt numeric_glob_sort

setopt auto_pushd #cd -[tab]
setopt pushd_ignore_dups #ignore duplicates in pushd

# enbrace ccl. Ex:{a-c} = a b c
setopt brace_ccl

# Use vi mode
bindkey -v


### Prompt
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:*' formats '[%F{green}%b%f]'
zstyle ':vcs_info:*' actionformats '[%F{green}%b%f(%F{red}%a%f)]'
precmd() { vcs_info }
PROMPT='[%n@%m]${vcs_info_msg_0_}
%#'
RPROMPT='[%F{yellow#n}%~%f] in %D %T'


### Aliases
alias du="du -h"
alias df="df -h"
alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'


#### OS specific settings
# Aliases
case $OSTYPE in
    darwin*)
		alias ls="ls -G"
		alias ll="ls -lG"
		alias la="ls -laG"
        ;;
    linux*)
		alias ls="ls --color"
		alias ll="ll -l --color"
		alias la="ls -la --color"
        ;;
esac


#### Useful commands definitions
### FZF
# open searched file with xorg-open
fo() {
  IFS=$'\n' out=("$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
  key=$(head -1 <<< "$out")
  echo $out
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}

# cd to a searched directory included hidden one
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}
# chrome historical search with fzf
ch() {
  local cols sep google_history open
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  if [ "$(uname)" = "Darwin" ]; then
    google_history="$HOME/Library/Application Support/Google/Chrome/Default/History"
    open=open
  else
    google_history="$HOME/.config/google-chrome/Default/History"
    open=xdg-open
  fi
  cp -f "$google_history" /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  fzf --ansi --multi --preview-window down:1 | sed 's#.*\(https*://\)#\1#' | xargs $open > /dev/null 2> /dev/null
}

