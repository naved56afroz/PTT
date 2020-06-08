set pages 1000 lines 200
col owner for a15
col name for a30
col type for a15
col referenced_owner for a15
col referenced_name for a30
select owner, name, type, referenced_owner, referenced_name, referenced_type from dba_dependencies where referenced_name=upper('&1');
