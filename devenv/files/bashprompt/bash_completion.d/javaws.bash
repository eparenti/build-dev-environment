_javaws()
{
    local cur prev opts base
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    # JavaWs Options
    opts="-version -arg -param -property -update -verbose -nosecurity -noupdate -headless -strict -xml -allowredirect -Xnofork -Xignoreheaders -Xoffline -Xtrustnone -jnlp -html -browser -about -viewer -Xclearcache -Xcacheids -license -help -Xtrustall"
    if [[ $prev == *"-jnlp" || $prev == *"-html" ]] ; then
      COMPREPLY=($(compgen -f -X "!*" -- ${cur}))
      if [ -d "$COMPREPLY" ] ; then
        COMPREPLY="$COMPREPLY/"
      fi
      return 0
    fi
    if [[ $cur == "" ]] ; then	
      COMPREPLY=($(compgen -W "aa_file_or_url ${opts} zz_file_or_url" -- ${cur}))
      return 0
    fi
    if [[ $cur == "-"* ]] ; then	
      COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
      return 0
    else
      COMPREPLY=($(compgen -f -X "!*" -- ${cur}))
      if [ -d "$COMPREPLY" ] ; then
        COMPREPLY="$COMPREPLY/"
      fi
      return 0
    fi
}
complete -F _javaws javaws
