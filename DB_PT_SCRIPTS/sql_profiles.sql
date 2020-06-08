set pages 400 lines 200
col created for a40
col last_modified for a40
col name for a50
select name,status,created,last_modified,force_matching from dba_sql_profiles order by 4;
