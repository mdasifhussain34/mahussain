# mahussain

#  Oracle DBA Monitoring & Performance Scripts

This repository contains useful Oracle Database scripts for DBAs to monitor, troubleshoot, and optimize database performance in real-time.  
All scripts are tested on **Oracle 19c** and compatible with 12c+.

---

##  Script List & Purpose

| Script Name | Purpose |
|------------|---------|
| `Blocking_session__` | Identify blocking and blocked sessions in the database |
| `High_Cpu_Sql` | Find SQL queries consuming high CPU resources |
| `Invalid_objects` | List all invalid database objects (packages, views, etc.) |
| `Long_run_sql` | Identify SQL queries running longer than expected |
| `Tablespace_usage` | Show current tablespace usage and free space details |
| `Active_user_sessions` | View currently active user sessions |
| `Temp_usage_session` | Check TEMP tablespace usage by active sessions |
| `Undo_usage_by_session` | Monitor UNDO consumption by sessions |
| `Failed or Broken_Scheduler_job` | Report broken or failed DB scheduler jobs |
| `Activelog_generation_per_hour` | Review archive log generation trend by hour |
| `oracle_backup.sh` | Automates Oracle database backup using RMAN and logs execution |
| `tablespace_alert.sh` | Alerts when tablespace usage exceeds defined threshold using SQL and shell automation |

---

##  How to Use

1. Connect to your Oracle database using SQL*Plus, SQL Developer, or any client.
2. Run the required script:
   ```sql
   @script_name.sql
