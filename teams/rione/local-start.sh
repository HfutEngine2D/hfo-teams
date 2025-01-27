#!/bin/sh

HOST="localhost"
BASEDIR=`pwd`
NUM=1

teamname="Ri-one"

player="./src/sample_player"
coach="./src/sample_coach"

config="src/player.conf"
config_dir="src/formations-dt"
coach_config="src/coach.conf"

opt="--player-config ${config} --config_dir ${config_dir}"
opt="${opt} -h ${HOST} -t ${teamname}"

coachopt="--coach-config ${coach_config}"
coachopt="${coachopt} -h ${HOST} -t ${teamname}"

cd $BASEDIR

LIBPATH=./lib
if [ x"$LIBPATH" != x ]; then
   if [ x"$LD_LIBRARY_PATH" = x ]; then
      LD_LIBRARY_PATH=$LIBPATH
   else
      LD_LIBRARY_PATH=$LIBPATH:$LD_LIBRARY_PATH
   fi
   export LD_LIBRARY_PATH
fi

while [ $NUM -le 12 ]
do
    case $NUM in
         1)
         $player $opt -g &
          ;;
         12)
         $coach $coachopt &
          ;;
         *)
         $player $opt &
         ;;
         esac
    sleep 0.01
    NUM=`expr $NUM + 1`
done
