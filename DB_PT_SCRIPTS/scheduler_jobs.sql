set lines 400 pages 10000
col REPEAT_INTERVAL for a75
col JOB_NAME for a30
col JOB_TYPE for a20
col state for a15
col owner for a20
col enabled for a10
col JOB_START_TIME for a40
col JOB_DURATION for a30
col JOB_INFO for a70
col JOB_STATUS for a20
col WINDOW_NAME for a30
col REPEAT_INTERVAL for a70
 COL DURATION for a30
 COL SCHEDLE_NAme for a30
 
select owner,job_name,job_type,enabled,state, repeat_interval  from dba_scheduler_jobs order by 4,1,2;

select window_name, autotask_status, optimizer_stats from dba_autotask_window_clients;


SELECT WINDOW_NAME,REPEAT_INTERVAL,DURATION,ENABLED FROM DBA_SCHEDULER_WINDOWS;

select job_status,job_start_time,job_duration,job_info
from dba_autotask_job_history
where job_start_time > systimestamp -14
and client_name='auto optimizer stats collection'
order by job_start_time ASC ;
