set line 400
col SEGMENT_NAME for a30
col segment_type for a30
select segment_name,segment_type, sum(bytes/1024/1024/1024) GB
from dba_segments
where segment_name='&1'
group by segment_name,segment_type;