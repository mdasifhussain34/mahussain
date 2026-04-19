#!/bin/bash

# Set Oracle environment variables
export ORACLE_HOME=/u01/app/oracle/product/19c/dbhome_1
export ORACLE_SID=ORCL
export PATH=$ORACLE_HOME/bin:$PATH

# Backup directory
BACKUP_DIR=/home/oracle/backups
DATE=$(date +%Y%m%d_%H%M%S)

# Log file
LOG_FILE=$BACKUP_DIR/backup_$DATE.log

echo "Starting Oracle DB Backup at $DATE" >> $LOG_FILE

# Run RMAN backup
rman target / <<EOF >> $LOG_FILE
RUN {
  BACKUP DATABASE FORMAT '$BACKUP_DIR/db_%U.bkp';
}
EXIT;
EOF

echo "Backup Completed at $(date)" >> $LOG_FILE
