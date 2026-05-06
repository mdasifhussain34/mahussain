#!/bin/bash

# Oracle environment variables
export ORACLE_HOME=/u01/app/oracle/product/19c/dbhome_1
export ORACLE_SID=ORCL
export PATH=$ORACLE_HOME/bin:$PATH

# Report directory
REPORT_DIR=/home/oracle/reports
DATE=$(date +%Y%m%d_%H%M%S)
REPORT_FILE=$REPORT_DIR/user_sessions_$DATE.log

echo "Generating Oracle User Session Report at $(date)" >> $REPORT_FILE

sqlplus -s / as sysdba <<EOF >> $REPORT_FILE
SET PAGESIZE 100
SET LINESIZE 200

SELECT 
    username,
    status,
    machine,
    program,
    logon_time
FROM 
    v\$session
WHERE 
    username IS NOT NULL
ORDER BY 
    logon_time DESC;

EXIT;
EOF

echo "User Session Report Completed at $(date)" >> $REPORT_FILE
