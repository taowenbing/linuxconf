alias h='history -25'
alias j='jobs -l'
alias lf='ls -AF'

autoload -U colors && colors
PROMPT="%{$fg_bold[red]%}%~> %{$reset_color%}"
