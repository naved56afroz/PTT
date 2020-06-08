set pages 1000
set lines 200
col Param for a60  heading "Parameter"
col InstanceVal format a15  heading "Instance Value"
col sessionval format a15  heading "Session Value"
col Descr for a80  heading "File Type"
SELECT
a.ksppinm Param ,
b.ksppstvl SessionVal ,
c.ksppstvl InstanceVal,
a.ksppdesc Descr
FROM
x$ksppi a ,
x$ksppcv b ,
x$ksppsv c
WHERE
a.indx = b.indx AND
a.indx = c.indx AND
a.ksppinm LIKE lower('%&1%')
ORDER BY 1;

set line 400
col NAME for a50
col DESCRIPTION for a70
 col VALUE for a10
 col DEFAULT_VALUE for a10
 select NAME,TYPE,VALUE,DEFAULT_VALUE,ISSYS_MODIFIABLE,ISSES_MODIFIABLE,DESCRIPTION from v$parameter where name like '%&1%';
