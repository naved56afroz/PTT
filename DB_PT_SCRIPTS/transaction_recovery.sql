set pages 1000 lines 200
select state, undoblocksdone, undoblockstotal, undoblocksdone / undoblockstotal * 100
from gv$fast_start_transactions; 
SELECT INST_ID, USN, STATE, UNDOBLOCKSTOTAL TOTAL, UNDOBLOCKSDONE DONE, UNDOBLOCKSTOTAL-UNDOBLOCKSDONE TODO, UNDOBLOCKSDONE / UNDOBLOCKSTOTAL * 100 PCT_COMPELETE, DECODE(CPUTIME,0,'UNKNOWN',SYSDATE+(((UNDOBLOCKSTOTAL-UNDOBLOCKSDONE) / (UNDOBLOCKSDONE / CPUTIME)) / 86400)) "ESTIMATED TIME TO COMPLETE" 
FROM GV$FAST_START_TRANSACTIONS;
select sysdate, b.name useg, a.ktuxeusn xidusn, a.ktuxeslt xidslot, a.ktuxesqn xidsqn 
from x$ktuxe a, undo$ b
where a.ktuxesta = 'ACTIVE'
and a.ktuxecfl like '%DEAD%'
and a.ktuxeusn = b.us#;
