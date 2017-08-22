# switch proxy env
proxy() {
  if [ ! -z ${http_proxy} ]; then
    MY_HTTP_PROXY=${http_proxy}
  fi
  if [ ! -z ${https_proxy} ]; then
    MY_HTTPS_PROXY=${https_proxy}
  fi
  if [ ! -z ${no_proxy} ]; then
    MY_NO_PROXY=${no_proxy}
  fi

  if [ $# = 0 ]; then
    echo "Usage: proxy on|off"
    echo ""
    env | grep proxy
  elif [ $1 == "on" ]; then
    export http_proxy=${MY_HTTP_PROXY}
    export https_proxy=${MY_HTTPS_PROXY}
    export no_proxy=${MY_NO_PROXY}
  elif [ $1 == "off" ]; then
    export http_proxy=
    export https_proxy=
    export no_proxy=
  fi
}

# word find
wf () {
  HELP_MSG="Usage: wf [-i] [-c] [-d path] word"

  # Backup previous OPTIND first because it must be set 1 while using getopts.
  # Without it, this command causes error if you use the command repeatedly.
  PREV_OPTIND=$OPTIND
  OPTIND=1

  COLOR_OPT=""
  IGNORE_CASE=""

  while getopts d:cih opts; do
    case $opts in
      d)
        DIR=$OPTARG;
        ;;
      c)
        COLOR_OPT="--color=always";
        ;;
      i)
        IGNORE_CASE="-i";
        ;;
      h)
        HELP_OPT=1;
        ;;
    esac
  done
  
  # Remove options from argments
  shift $(($OPTIND -1)) 
  ARGNUM=$#  # ARGNUM should be 1

  if [ ${ARGNUM} -eq 0 ]; then
    echo ${HELP_MSG}
  elif [ ! ${DIR} = '' ]; then
    find ${DIR} -type f | xargs egrep -n ${IGNORE_CASE} ${COLOR_OPT} $1
  else
    find . -type f | xargs egrep -n ${IGNORE_CASE} ${COLOR_OPT} $1
  fi

  # Finally, restore the previous OPTIND.
  OPTIND=$PREV_OPTIND
}
