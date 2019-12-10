export EDITOR=vim

YELLOW='\e[0;93m'
RED='\e[1;31m'

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

PS1="\[$YELLOW\]\u@\[$RED\]\h:\w\$(parse_git_branch)\$\[\e[0m\] "

###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -n : -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
    if type __ltrim_colon_completions &>/dev/null; then
      __ltrim_colon_completions "${words[cword]}"
    fi
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###

if [ -f $(brew --prefix)/etc/bash_completion ]; then
 . $(brew --prefix)/etc/bash_completion
fi

if test -f "/usr/local/bin/vim"; then
    alias vim="/usr/local/bin/vim"
    alias vi="/usr/local/bin/vim"
else
    echo "vi not installed by homebrew; .vimrc may not work as expected"
fi

alias ls="ls -Gp"
alias gw="./gradlew"
alias git-search="git branch -r --contains"
alias publishLocal="gw printVersion publishToMavenLocal"
alias webServer="python -m SimpleHTTPServer 8000"
alias gs="git status"
alias gco="git commit"
alias gch="git checkout"
alias gf="git fetch"
alias gr="git rebase"
alias gm="git merge"
alias gl="git log"
alias gfr="git fetch && git rebase"
alias gd="git diff"
alias ga="git add"
alias gp="git push"

export PYENV_ROOT=/usr/local/opt/pyenv
eval "$(pyenv init -)"
# pyenv global 3.7.0

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/emarshak/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/Users/emarshak/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/emarshak/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/emarshak/Downloads/google-cloud-sdk/completion.bash.inc'; fi
