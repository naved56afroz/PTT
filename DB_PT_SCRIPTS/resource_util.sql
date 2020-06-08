  set line 400
 col RESOURCE_NAME for a30
 col LIMIT_VALUE for a20
 select resource_name, current_utilization, max_utilization, limit_value  from v$resource_limit 
where resource_name in ('sessions', 'processes');
