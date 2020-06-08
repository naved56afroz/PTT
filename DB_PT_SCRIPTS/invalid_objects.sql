set line 400
col owner for a30
col object_name for a30
col object_type for a30
col status for a30
col created for a30
select owner,object_name,object_type,status,created from dba_objects where status='INVALID' and 
owner not in ('SYSTEM','SYS','DBSNMP','A_ORAAUDIT_I');