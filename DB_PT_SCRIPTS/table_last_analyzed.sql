set line 400
col OWNER for a20
col LAST_ANALYZED for a40
col TABLE_NAME for a30
select owner,table_name,to_char(LAST_ANALYZED,'DD-MON-YYYY HH24:MI:ss') from dba_tables where table_name in ('&1');
