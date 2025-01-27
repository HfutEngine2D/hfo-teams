#!/bin/sh


LIBPATH=/home/twocows/local//lib
if [ x"$LIBPATH" != x ]; then
  if [ x"$LD_LIBRARY_PATH" = x ]; then
    LD_LIBRARY_PATH=$LIBPATH
  else
    LD_LIBRARY_PATH=$LIBPATH:$LD_LIBRARY_PATH
  fi
  export LD_LIBRARY_PATH
fi

DIR=`dirname $0`

player="${DIR}/sample_player"
coach="${DIR}/sample_coach"
trainer="${DIR}/helios_trainer"
teamname="HELIOS"
host="localhost"

config="${DIR}/player.conf"
config_dir="${DIR}/formations-train"

number=11
usecoach="true"

sleepprog=sleep
goaliesleep=1
sleeptime=0

debugopt="--offline_logging --debug --debug_server_connect"

usage()
{
  (echo "Usage: $0 [options]"
   echo "Possible options are:"
   echo "      --help                print this"
   echo "  -h, --host HOST           specifies server host"
   echo "  -t, --teamname TEAMNAME   specifies team name") 1>&2
}

while [ $# -gt 0 ]
	do
	case $1 in

    --help)
      usage
      exit 0
      ;;

    -h|--host)
      if [ $# -lt 2 ]; then
        usage
        exit 1
      fi
      host=$2
      shift 1
      ;;

    -t|--teamname)
      if [ $# -lt 2 ]; then
        usage
        exit 1
      fi
      teamname=$2
      shift 1
      ;;

    *)
      usage
      exit 1
      ;;
  esac

  shift 1
done

OPT="-h ${host} -t ${teamname}"
OPT="${OPT} --player-config ${config} --config_dir ${config_dir}"
OPT="${OPT} ${debugopt}"

#if [ $number -gt 0 ]; then
#  $player ${OPT} -g &
#  $sleepprog $goaliesleep
#fi

#for (( i=2; i<=${number}; i=$i+1 )) ; do
  $player ${OPT} -n 11 &
  $sleepprog $sleeptime
#done

#if [ "${usecoach}" = "true" ]; then
#  $coach -h $host -t $teamname &
#fi

$trainer -h $host -t $teamname &
