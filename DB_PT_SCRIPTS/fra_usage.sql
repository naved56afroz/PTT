set pages 1000 lines 200
col name format a30
col USED_MB format 999,999,999
col RECLAIMABLE_MB format 999,999,999
col NUMBER_OF_FILES format 999,999,999
select	name,	floor(space_limit / 1024 / 1024) "Size MB",	ceil(space_used  / 1024 / 1024) "Used MB",  
(ceil((space_used  / 1024 / 1024)*100/floor(space_limit / 1024 / 1024))) "% USED",
(floor(space_limit / 1024 / 1024) - (ceil(space_used  / 1024 / 1024))) "Free MB"  
from v$recovery_file_dest order by name;
SELECT
  rau.file_type,
  floor(rfd.space_used * rau.percent_space_used / 1024 / 1024) as USED_MB,
  floor(rfd.space_reclaimable * rau.percent_space_reclaimable / 1024 / 1024) as RECLAIMABLE_MB,
  rau.number_of_files as NUMBER_OF_FILES
FROM
  v$recovery_file_dest rfd, v$flash_recovery_area_usage rau;
