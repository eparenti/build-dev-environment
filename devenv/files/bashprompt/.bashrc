# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f /etc/bash_completion.d/lab_completion.bash ]; then
    . /etc/bash_completion.d/lab_completion.bash
fi

# User specific environment
PATH="$HOME/.local/bin:$HOME/bin:/home/eparenti/vscodium:$PATH"
export PATH

if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    RED="\[\033[0;31m\]"
    CYAN="\[\033[0;36m\]"
    GREEN="\[\033[0;32m\]"
    YELLOW="\[\033[0;33m\]"
    source $HOME/.bash-git-prompt/gitprompt.sh
fi

alias activate='source ~/.venv/rht-labs-core/bin/activate'
alias sshkey='eval $(ssh-agent) && ssh-add ~/.ssh/id_rsa'
alias deletemerged='git branch --merged | egrep -v "(^\*|master)" | xargs git branch -d'
alias showmerged='git branch --merged | egrep -v "(^\*|master)"'
alias spellcheck='for f in *; do aspell -c $f; done'
alias spellinglist='for f in * ; do echo $f ; aspell list < $f | sort | uniq -c ; done'
alias spellr="aspell --mode=asciidoc list | sort | uniq -c | sort -rn"
alias spellrxml="aspell list | sort | uniq -c | sort -rn"
