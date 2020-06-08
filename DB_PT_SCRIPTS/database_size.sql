set pages 1000 lines 200
column dummy noprint
column  file_type    format a16      heading "File Type"
column  size_gb   format 999,999,999.99    heading "Size(GB)"
break   on report
col "Database Size" format a20
col "Free space" format a20
col "Used space" format a20
compute sum of size_gb on report
select 'Datafiles' file_type, round(sum(bytes)/1024/1024/1024,2) size_gb from dba_data_files
union
select 'Tempfiles' file_type, round(nvl(sum(bytes),0)/1024/1024/1024,2) size_gb from dba_temp_files
union
select 'Redo Logs' file_type, round(sum(bytes)/1024/1024/1024,2) size_gb from sys.v_$log
union
select 'Controlfile' file_type, round(sum(BLOCK_SIZE*FILE_SIZE_BLKS)/1024/1024/1024,2) size_gb from v$controlfile
order by 2 desc;
select round(sum(used.bytes) / 1024 / 1024 / 1024,2 ) || ' GB' "Database Size"
, round(sum(used.bytes) / 1024 / 1024 / 1024,2 ) - round(free.p / 1024 / 1024 / 1024,2) || ' GB' "Used space"
, round(free.p / 1024 / 1024 / 1024,2) || ' GB' "Free space"
from (select bytes
from v$datafile
union all
select bytes
from v$tempfile
union all
select bytes
from v$log) used
, (select sum(bytes) as p
from dba_free_space) free
group by free.p;


