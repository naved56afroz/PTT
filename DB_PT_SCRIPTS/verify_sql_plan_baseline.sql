select count(*) from v$sql where sql_id ='&1' and sql_plan_baseline is not null ;
