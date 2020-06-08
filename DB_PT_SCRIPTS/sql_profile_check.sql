set pages 1000 lines 200
select count(1) from dba_sql_profiles where name like 'coe_$1' and STATUS='ENABLED' and LAST_MODIFIED > sysdate-1/96;
