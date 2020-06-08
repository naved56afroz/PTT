set lines 100
	col name format a10;
	col Arch_Date a50;
select to_char(COMPLETION_TIME,'DD-MON-YYYY') Arch_Date,count(*) No#_Logs,
sum((BLOCKS*512)/1024/1024/1024) Arch_LogSize_GB
from v$archived_log
where to_char(COMPLETION_TIME,'DD-MON-YYYY')>=trunc(sysdate-7) and DEST_ID=1
group by to_char(COMPLETION_TIME,'DD-MON-YYYY')
order by to_char(COMPLETION_TIME,'DD-MON-YYYY');

select MAX(count(SEQUENCE#))* sum((BLOCKS*512)/1024/1024/1024) * &1
from v$archived_log
where to_char(COMPLETION_TIME,'DD-MON-YYYY')>=trunc(sysdate-7) and DEST_ID=1
group by to_char(COMPLETION_TIME,'DD-MON-YYYY'),BLOCKS
order by to_char(COMPLETION_TIME,'DD-MON-YYYY');

	set lines 100
		col name format a10;
		select	name,	floor(space_limit / 1024 / 1024/1024) "Size GB",	ceil(space_used  / 1024 / 1024/1024) "Used GB",
		(ceil(space_used  / 1024 / 1024/1024)*100/floor(space_limit / 1024 / 1024/1024)) "% USED",
		(floor(space_limit / 1024 / 1024/1024) - (ceil(space_used  / 1024 / 1024/1024))) "Free GB"
		from	v$recovery_file_dest order by name;
