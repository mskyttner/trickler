#!/bin/bash
set -x

reload() {
  nohup Rscript /start-trickler.R 8080 entrypoint.R > /proc/1/fd/1 &
  DEV_SERVER_PID=$!
  PROCESS_RELOADING=0
}

reload

inotifywait -m -r -e modify $PLUMBER_DIR | while read CHANGE_EVENT;
do
  if [ $PROCESS_RELOADING -ne 1 ];
    then
      PROCESS_RELOADING=1
      echo "$CHANGE_EVENT detected.... reloading PID:$DEV_SERVER_PID... "
      kill $DEV_SERVER_PID
      reload
    fi
done

