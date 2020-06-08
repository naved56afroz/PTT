set line 400
col TABLE_OWNER for a30
col TABLE_NAME for a40
select TABLE_OWNER, TABLE_NAME, INSERTS, UPDATES, DELETES,
to_char(TIMESTAMP,'YYYY-MON-DD HH24:MI:SS')
from all_tab_modifications
where table_owner<>'SYS' and
TIMESTAMP > sysdate-15
order by 6;
