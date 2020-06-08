set pages 10000 lines 200
select tablespace_name, status, round(sum(blocks) * 8192/1024/1024/1024,2) GB from dba_undo_extents group by tablespace_name, status;
SELECT S.INST_ID, S.SID, S.SERIAL#, T.XIDUSN, T.XIDSLOT, T.XIDSQN, T.STATUS, T.START_TIME, T.USED_UBLK, T.USED_UREC 
FROM GV$TRANSACTION T, GV$SESSION S WHERE T.ADDR = S.TADDR;
