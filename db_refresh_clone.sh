#!/bin/bash

# Oracle environment variables
export ORACLE_HOME=/u01/app/oracle/product/19c/dbhome_1
export ORACLE_SID=TESTDB
export PATH=$ORACLE_HOME/bin:$PATH

# Log directory
LOG_DIR=/home/oracle/logs
DATE=$(date +%Y%m%d_%H%M%S)
LOG_FILE=$LOG_DIR/db_refresh_$DATE.log

echo "Database Refresh Started at $(date)" >> $LOG_FILE

# Shutdown database
sqlplus / as sysdba <<EOF >> $LOG_FILE
SHUTDOWN IMMEDIATE;
STARTUP MOUNT;
EXIT;
EOF

# Restore database using RMAN
rman target / <<EOF >> $LOG_FILE
RUN {
    RESTORE DATABASE;
    RECOVER DATABASE;
}
EXIT;
EOF

# Open database
sqlplus / as sysdba <<EOF >> $LOG_FILE
ALTER DATABASE OPEN RESETLOGS;
EXIT;
EOF

echo "Database Refresh Completed at $(date)" >> $LOG_FILE
