col owner for a15
col view_name for a30
col type for a15
col referenced_owner for a15
col referenced_name for a30
select owner, name view_name, referenced_owner, referenced_name,referenced_type from dba_dependencies where name in ('&1') order by 2;
