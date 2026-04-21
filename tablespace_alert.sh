#!/bin/bash

# Oracle environment
export ORACLE_HOME=/u01/app/oracle/product/19c/dbhome_1
export ORACLE_SID=ORCL
export PATH=$ORACLE_HOME/bin:$PATH

# Threshold
THRESHOLD=80

# Run SQL query
sqlplus -s / as sysdba <<EOF
SET PAGESIZE 100
SET LINESIZE 200

SELECT 
    tablespace_name,
    ROUND((used_space/total_space)*100,2) AS usage_percent
FROM (
    SELECT 
        df.tablespace_name,
        SUM(df.bytes)/1024/1024 AS total_space,
        SUM(df.bytes - NVL(fs.bytes,0))/1024/1024 AS used_space
    FROM dba_data_files df
    LEFT JOIN (
        SELECT tablespace_name, SUM(bytes) bytes
        FROM dba_free_space
        GROUP BY tablespace_name
    ) fs ON df.tablespace_name = fs.tablespace_name
    GROUP BY df.tablespace_name
)
WHERE (used_space/total_space)*100 > $THRESHOLD;

EXIT;
EOF
