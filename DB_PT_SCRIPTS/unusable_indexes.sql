set pages 1000 lines 200
col owner for a15
SELECT OWNER OWNER, INDEX_NAME AS "INDEX OR PART OR SUBPART NAME", STATUS, PARTITIONED AS "PARTITION"
FROM   DBA_INDEXES WHERE STATUS='UNUSABLE'
UNION ALL
SELECT INDEX_OWNER OWNER, INDEX_NAME AS "INDEX OR PART OR SUBPART NAME", STATUS, PARTITION_NAME AS "PARTITION"
FROM   DBA_IND_PARTITIONS WHERE STATUS='UNUSABLE'
UNION ALL
SELECT INDEX_OWNER OWNER, INDEX_NAME||'.'||PARTITION_NAME AS "INDEX OR PART OR SUBPART NAME", STATUS, SUBPARTITION_NAME AS "PARTITION"
FROM   DBA_IND_SUBPARTITIONS WHERE STATUS='UNUSABLE';
