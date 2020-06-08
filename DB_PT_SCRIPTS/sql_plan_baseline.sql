set line 400
col SQL_HANDLE for a20
col CREATOR for a10
col CREATED for a30
col PLAN_NAME for a30
col ORIGIN for a20
col sql_text for a50
col LAST_EXECUTED for a40
select plan_name,sql_handle,fixed,enabled, accepted,CREATOR,ORIGIN,created,last_executed FROM dba_sql_plan_baselines order by CREATED; 
