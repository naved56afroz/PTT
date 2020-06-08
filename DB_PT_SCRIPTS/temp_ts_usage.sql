set pages 1000 lines 200
column tablespace for a15
column username for a20
column program  for a40
col tablespace_name for a40  heading "Tablespace Name"
col ts_size for 999.99  heading "Size (GB)"
col alloc_size for 999.99 heading "Allocated size(GB)"
col free_space for 999.99 heading "Free Space(GB)"
select tablespace_name ,round(tablespace_size/1024/1024/1024,2) ts_size,round(allocated_space/1024/1024/1024,2) alloc_size,round(free_space/1024/1024/1024,2) free_space
from   dba_temp_free_space;
select unique  a.inst_id
	   , b.tablespace
       , b.segfile#
       , b.segblk#
       , round (  (  ( b.blocks * p.value ) / 1024 / 1024 ), 2 ) size_mb
       , a.sid
       , a.serial#
       , a.username
       , a.program
       , a.status
    from gv$session a
       , gv$sort_usage b
       , gv$process c
       , gv$parameter p
   where p.name = 'db_block_size'
     and a.inst_id = b.inst_id
     and a.saddr = b.session_addr
     and a.paddr = c.addr
order by 1,2;

--------->sort area
col USERNAME for a30
col TABLESPACE for a30
col uname for a30
select ( select username from v$session where saddr = session_addr) uname,v.blocks,v.username,v.sql_id,v.tablespace from v$sort_usage v ;


-------->temp usage history

select sql_id,max(TEMP_SPACE_ALLOCATED)/(1024*1024*1024) gig
from DBA_HIST_ACTIVE_SESS_HISTORY
where sample_time > sysdate-7/24 and
TEMP_SPACE_ALLOCATED > (100*1024*1024)
group by sql_id order by sql_id;

--->Who is using temp

set line 400 pages 100
col TABLESPACE for a15
col USERNAME for a20
col osuser for a15
col PROGRAM for a45
SELECT   b.TABLESPACE
       , b.segfile#
       , b.segblk#
       , ROUND (  (  ( b.blocks * p.VALUE ) / 1024 / 1024 ), 2 ) size_mb
       , a.SID
    , a.serial#
       , a.username
       , a.osuser
       , a.program
       , a.status
    FROM v$session a
       , v$sort_usage b
       , v$process c
       , v$parameter p
   WHERE p.NAME = 'db_block_size'
     AND a.saddr = b.session_addr
     AND a.paddr = c.addr
ORDER BY b.TABLESPACE
       , b.segfile#
       , b.segblk#
       , b.blocks;

--->Temp file size
set line 400
col name for a70;
select file#,name,bytes/1024/1024/1024 SIZE_GB from v$tempfile;
