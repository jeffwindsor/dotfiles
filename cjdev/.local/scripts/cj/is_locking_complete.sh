#!/bin/bash

echo "executing check for locking complete"

SQLPLUS="/Users/jefwinds/src/gitlab.cj.dev/cjdev/software/sqlplus/darwin/sqlplus"

RESULT=`$SQLPLUS -S $SHOPCART_USER/$SHOPCART_PASSWORD_SECRET@$TNS_SERVICE_SECRET << EOF
  set feedback off pagesize 0 trimout on;
  whenever sqlerror exit;

  Select count(1)
  from ACTION_LOCKING_PROCESS_LOG
  where LOCKED_UP_TO_PST = TRUNC(sysdate)
    and COMPLETION_STATE = 'completed';
    
EOF`

RESULT=$(echo $RESULT | xargs)
echo "Locking Result: $RESULT"

# A COUNT of 1 means that action locking has completed for today
if [[ $RESULT == "1"  ]]; then
  echo "Locking Complete"
  exit 0
else
  echo "Locking Incomplete"
  exit 1
fi