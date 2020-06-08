col file_name for a60;
set pagesize 500;
set linesize 500;
SELECT SUBSTR (df.NAME, 1, 40) file_name, df.bytes / 1024 / 1024 allocated_mb,
((df.bytes / 1024 / 1024) - NVL (SUM (dfs.bytes) / 1024 / 1024, 0))
used_mb,
NVL (SUM (dfs.bytes) / 1024 / 1024, 0) free_space_mb
FROM v$datafile df, dba_free_space dfs
WHERE df.file# = dfs.file_id(+)
GROUP BY dfs.file_id, df.NAME, df.file#, df.bytes
ORDER BY file_name;