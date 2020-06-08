set pages 1000 lines 200
col created for a40
col last_modified for a40
select name,status,created,last_modified,force_matching from dba_sql_profiles order by 4;
