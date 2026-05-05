#!/bin/bash

# Oracle environment variables
export ORACLE_HOME=/u01/app/oracle/product/19c/dbhome_1
export ORACLE_SID=ORCL
export PATH=$ORACLE_HOME/bin:$PATH

# Log directory
LOG_DIR=/home/oracle/logs
DATE=$(date +%Y%m%d_%H%M%S)
LOG_FILE=$LOG_DIR/archive_cleanup_$DATE.log

echo "Archive log cleanup started at $(date)" >> $LOG_FILE

rman target / <<EOF >> $LOG_FILE
CROSSCHECK ARCHIVELOG ALL;
DELETE NOPROMPT ARCHIVELOG UNTIL TIME 'SYSDATE-7';
EXIT;
EOF

echo "Archive log cleanup completed at $(date)" >> $LOG_FILE
