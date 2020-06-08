set line 400
col owner for a30
col table_name for a30
col partition_name for a30
col subpartition_name for a30
col last_analyzed for a30
select owner,table_name,partition_name,subpartition_name,num_rows,last_analyzed from dba_tab_statistics where stale_stats='YES' and owner not in ('SYSTEM','SYS','DBSNMP','A_ORAAUDIT_I','MDSYS','ORDDATA','XDB','SYS','SYSTEM','DBSNMP','SQLTXPLAIN');
