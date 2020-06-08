set lines 400
col host_name for a20
col db_unique_name for a13
col VERSION for a10
col OPEN_MODE for a15
col INSTANCE_NAME for a16
col NAME for a10
col LOGINS for a10
col STATUS for a10
col DATABASE_ROLE for a15
col log_mode for a15
col TO_CHAR(STARTUP_TIME,'DD-MON-YYYYHH24:MI:SS') for a30
SELECT name,db_unique_name,VERSION,open_mode,logins,INSTANCE_NAME,host_name,dbid,TO_CHAR(STARTUP_TIME,'DD-MON-YYYY HH24:MI:SS'),STATUS,database_role,log_mode FROM v$database,gv$INSTANCE;
