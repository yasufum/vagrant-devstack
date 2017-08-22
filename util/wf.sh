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
