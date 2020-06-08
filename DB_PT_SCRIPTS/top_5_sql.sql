set line 400
col Snap_Day for a10
col Sql for a70
col sql_id for a15
SELECT *
FROM (SELECT RANK () OVER
(PARTITION BY "Snap_Day" ORDER BY "Buffer Gets" + "Disk Reads" DESC) AS "Rank", i1.*
FROM (SELECT TO_CHAR (hs.begin_interval_time, 'YYYY-MM-DD' ) "Snap_Day",
SUM (shs.executions_delta) "Execs",
SUM (shs.buffer_gets_delta) "Buffer Gets",
SUM (shs.disk_reads_delta) "Disk Reads",
ROUND ( (SUM (shs.buffer_gets_delta)) / SUM (shs.executions_delta), 1 ) "Gets/Exec",
ROUND ( (SUM (shs.cpu_time_delta) / 1000000) / SUM (shs.executions_delta), 1 ) "CPU/Exec(S)",
ROUND ( (SUM (shs.iowait_delta) / 1000000) / SUM (shs.executions_delta), 1 ) "IO/Exec(S)",
shs.sql_id "sql_id",
REPLACE (CAST (DBMS_LOB.SUBSTR (sht.sql_text, 50) AS VARCHAR (50) ), CHR (10), '' ) "Sql"
FROM dba_hist_sqlstat shs INNER JOIN dba_hist_sqltext sht
ON (sht.sql_id = shs.sql_id)
INNER JOIN dba_hist_snapshot hs
ON (shs.snap_id = hs.snap_id)
HAVING SUM (shs.executions_delta) > 0
GROUP BY shs.sql_id, TO_CHAR (hs.begin_interval_time, 'YYYY-MM-DD'),
CAST (DBMS_LOB.SUBSTR (sht.sql_text, 50) AS VARCHAR (50) )
ORDER BY "Snap_Day" DESC) i1
ORDER BY "Snap_Day" DESC)
WHERE "Rank" <= 5 AND "Snap_Day" = TO_CHAR (SYSDATE, 'YYYY-MM-DD');