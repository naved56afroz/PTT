set pages 1000 lines 200
select name, trunc(bytes/1024/1024) size_mb,resizeable from v$sgainfo ;
select round(used.bytes /1024/1024 ,2) used_mb
,round(free.bytes /1024/1024 ,2) free_mb
,round(tot.bytes /1024/1024 ,2) total_mb	
from (select sum(bytes) bytes
from v$sgastat
where name != 'free memory') used
,(select sum(bytes) bytes
from v$sgastat
where name = 'free memory') free
,(select sum(bytes) bytes
from v$sgastat) tot ;
