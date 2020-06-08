set line 400
col event for a45
col wait_class for a20
col instance_user_sid_serial for a30
break on instance_user_sid_serial
TTITLE LEFT '# Current Waits for Active session #' SKIP 1 LEFT '= = = = = = = = = = = = = = = = = = = = = = = =  ' SKIP  2
select 'Inst'||a.inst_id||'-'||b.username||'.'||b.sid||'.'||b.serial# instance_user_sid_serial, a.wait_class, a.event, trunc(a.time_waited/100) wait_time_sec, a.total_waits,  round(a.average_wait/100,2) average_wait_sec
from gv$session_event a, gv$session b
where time_waited > 0
and a.sid=b.sid
and a.inst_id=b.inst_id
and b.username is not NULL
and b.status='ACTIVE'
order by 1,5 desc;
