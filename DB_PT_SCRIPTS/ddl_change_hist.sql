set line 400
col OWNER for a30
col OBJECT_NAME for a30
col OBJECT_TYPE for a30
select owner,object_name,object_type,status,created,last_ddl_time from dba_objects where owner not in ('SYSTEM','SYS','DBSNMP','A_ORAAUDIT_I','ORDDATA','SQLTXPLAIN','MDSYS','XDB','SQLTXPLAIN')
and object_type='TABLE' and last_ddl_time > sysdate -3 order by 6;
