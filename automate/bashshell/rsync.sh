#!/usr/bin/env bash

do_rsync(){
  rsync -av  --progress --exclude ".git" --exclude ".pyc" . root@corevm.livenowhy.com::share/  --password-file=/share/rsyncd.passwd
}

do_loop_rsync(){
  while true
  do
    do_rsync
    sleep 5
  done
}


do_rsync
do_loop_rsync

# vim /share/rsyncd.passwd
# J2V8h6MsRwzy
# chmod 600 /share/rsyncd.passwd

# ln -s /share/notebook/automate/bashshell/rsync.sh /share/rsync.sh