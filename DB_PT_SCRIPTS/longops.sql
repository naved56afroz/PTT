set lines 200
col OPNAME for a40
select sid,serial#,opname,totalwork,start_time,time_remaining/60 "REMAINING_TIME",elapsed_seconds/60 "ELAPSED_TIME",round(sofar/totalwork*100,2) "% Complete" 
FROM V$SESSION_LONGOPS WHERE
totalwork != 0 and time_remaining>0 order by start_time;