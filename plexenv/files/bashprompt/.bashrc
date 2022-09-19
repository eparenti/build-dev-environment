# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f /etc/bash_completion.d/lab_completion.bash ]; then
    . /etc/bash_completion.d/lab_completion.bash
fi

if [ -f ~/.bashrc_dynolabs ]; then
    . ~/.bashrc_dynolabs
fi

# User specific environment
# PATH="$HOME/.local/bin:$HOME/bin:$HOME/dev/build-dev-environment/devenv/files/bin/:$PATH"
export PATH

if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    RED="\[\033[0;31m\]"
    CYAN="\[\033[0;36m\]"
    GREEN="\[\033[0;32m\]"
    YELLOW="\[\033[0;33m\]"
    source $HOME/.bash-git-prompt/gitprompt.sh
fi

#PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\] @ \w\[\033[0;32m\] - [$(git branch 2>/dev/null | grep "^*" | colrm 1 2)\[\033[0;32m\]]\[\033[0m\033[0;32m\] \$\[\033[0m\033[0;32m\]\[\033[0m\] '

PS1='\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\] @ \w\[\033[0;32m\]\n$(git branch 2>/dev/null | grep "^*" | colrm 1 2)\[\033[0;32m\]└─\[\033[0m\033[0;32m\] \$\[\033[0m\033[0;32m\]\[\033[0m\] '



alias ll='exa --long --header --git'
alias activate='source ~/.venv/rht-labs-core/bin/activate'
alias sshkey='eval $(ssh-agent) && ssh-add ~/.ssh/id_rsa'
alias deletemerged='git branch --merged | egrep -v "(^\*|master)" | xargs git branch -d'
alias showmerged='git branch --merged | egrep -v "(^\*|master)"'
alias spellcheck='for f in *; do aspell -c $f; done'
alias spellinglist='for f in * ; do echo $f ; aspell list < $f | sort | uniq -c ; done'
alias spellr="aspell --mode=asciidoc list | sort | uniq -c | sort -rn"
alias spellrxml="aspell list | sort | uniq -c | sort -rn"
alias flamel="flamel.sh"
alias rebuild='flamel clean; flamel sg; evince ./tmp/en-US/pdf/*'
alias activate='source ~/.venv/labs/bin/activate'
alias dynobuild='cd ~/dev/DO374/classroom/grading/; make clean; make build; pip install --no-cache-dir dist/*.gz'
alias labs='cd ~/.venv/labs/lib/python3.6/site-packages/do467/'
alias acvar="cd ~/.venv/labs/lib/python3.6/site-packages/do467/ansible/group_vars/all/exercises/automation_controller/"


# eval "$(starship init bash)"
