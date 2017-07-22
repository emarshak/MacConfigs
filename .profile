export EDITOR=vim

YELLOW='\e[0;93m'
RED='\e[1;31m'

PS1="\[$YELLOW\]\u@\[$RED\]\h:\w\$\[\e[0m\] "

alias ls="ls -Gp"
alias gw="./gradlew"
alias git-search="git branch -r --contains"
alias publishLocal="gw printVersion publishToMavenLocal"
