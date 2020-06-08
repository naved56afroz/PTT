set pages 1000 lines 200
col event for a45
set line 400
col WAIT_CLASS for a40
TTITLE LEFT '# System wide Wait events since last DB startup #' SKIP 1 LEFT '= = = = = = = = = = = = = = = = = = = = = = = = = = = = =  ' SKIP  2
select * from (
select  a.wait_class, a.event, trunc(a.time_waited/100) wait_time_sec, a.total_waits,  round(a.average_wait/100,2) average_wait_sec
from gv$system_event a
where event not like 'SQL*Net%'
and event not in ('pmon timer','rdbms ipc message','dispatcher timer','smon timer')
and wait_class not in ('Idle')
order by time_waited desc )
where rownum < 11;
