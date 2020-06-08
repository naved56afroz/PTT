set line 400
col RESOURCE_NAME for a30					  
select snap_id,RESOURCE_NAME,CURRENT_UTILIZATION,MAX_UTILIZATION from DBA_HIST_RESOURCE_LIMIT where resource_name in ('sessions', 'processes') and snap_id > ( select max(snap_id)-3 from DBA_HIST_RESOURCE_LIMIT) order by 1;
