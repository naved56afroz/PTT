create or replace table RA_test
tablespace TEST_TABLESPACE
as
select * from RATEST.TEST;

 select * from nava.SCALE_DATA;
 
 select avg(sqrt(id2))  from nava.scale_data where ID1 < = 890000 and ID1 > = 3000;


select * from v$sql where sql_id ='fdukp147a4cuy';

select * from  dba_hist_sql_plan where sql_id ='fdukp147a4cuy';
select sql_id, plan_hash_value, exact_matching_signature,FORCE_MATCHING_SIGNATURE, sql_plan_baseline from v$sql where sql_id ='fdukp147a4cuy';

SELECT SQL_FULLTEXT,sql_plan_baseline   FROM v$sql where sql_id ='fdukp147a4cuy';
SELECT SQL_TEXT,plan_name   FROM dba_sql_plan_baselines where SQL_TEXT like '%a.INST_ID,%';
SQL_PLAN_2xtaaf9v6x5kkc29f3b8f
SQL_PLAN_12kgfmg69shj31b4f8f21

SELECT plan_name 
FROM dba_sql_plan_baselines a,v$sql b
where a.SQL_TEXT = b.SQL_FULLTEXT and b.sql_id ='fdukp147a4cuy';

select PLAN_NAME  
FROM dba_sql_plan_baselines a,v$sql b
where sql_id ='fdukp147a4cuy'
and a.sql_text=b.sql_text;



select count(1) from v$sql where sql_id ='fdukp147a4cuy' and sql_plan_baseline is not null ;

select count(1) from RATEST.TEST;

SELECT * FROM
(select OWNER,
SEGMENT_NAME,
SEGMENT_TYPE,
BYTES/1024/1024/1024 GB,
TABLESPACE_NAME
from
dba_segments
order by 4 desc ) WHERE
ROWNUM <= 10

WITH
FUNCTION compute_sql_id (sql_text IN CLOB)
RETURN VARCHAR2 IS
 BASE_32 CONSTANT VARCHAR2(32) := '0123456789abcdfghjkmnpqrstuvwxyz';
 l_raw_128 RAW(128);
 l_hex_32 VARCHAR2(32);
 l_low_16 VARCHAR(16);
 l_q3 VARCHAR2(8);
 l_q4 VARCHAR2(8);
 l_low_16_m VARCHAR(16);
 l_number NUMBER;
 l_idx INTEGER;
 l_sql_id VARCHAR2(13);
BEGIN
 l_raw_128 := /* use md5 algorithm on sql_text and produce 128 bit hash */
 SYS.DBMS_CRYPTO.hash(TRIM(CHR(0) FROM sql_text)||CHR(0), SYS.DBMS_CRYPTO.hash_md5);
 l_hex_32 := RAWTOHEX(l_raw_128); /* 32 hex characters */
 l_low_16 := SUBSTR(l_hex_32, 17, 16); /* we only need lower 16 */
 l_q3 := SUBSTR(l_low_16, 1, 8); /* 3rd quarter (8 hex characters) */
 l_q4 := SUBSTR(l_low_16, 9, 8); /* 4th quarter (8 hex characters) */
 /* need to reverse order of each of the 4 pairs of hex characters */
 l_q3 := SUBSTR(l_q3, 7, 2)||SUBSTR(l_q3, 5, 2)||SUBSTR(l_q3, 3, 2)||SUBSTR(l_q3, 1, 2);
 l_q4 := SUBSTR(l_q4, 7, 2)||SUBSTR(l_q4, 5, 2)||SUBSTR(l_q4, 3, 2)||SUBSTR(l_q4, 1, 2);
 /* assembly back lower 16 after reversing order on each quarter */
 l_low_16_m := l_q3||l_q4;
 /* convert to number */
 SELECT TO_NUMBER(l_low_16_m, 'xxxxxxxxxxxxxxxx') INTO l_number FROM DUAL;
 /* 13 pieces base-32 (5 bits each) make 65 bits. we do have 64 bits */
 FOR i IN 1 .. 13
 LOOP
 l_idx := TRUNC(l_number / POWER(32, (13 - i))); /* index on BASE_32 */
 l_sql_id := l_sql_id||SUBSTR(BASE_32, (l_idx + 1), 1); /* stitch 13 characters */
 l_number := l_number - (l_idx * POWER(32, (13 - i))); /* for next piece */
 END LOOP;
 RETURN l_sql_id;
END compute_sql_id;
SELECT compute_sql_id(sql_text) sql_id, signature
  FROM dba_sql_plan_baselines 
/



WITH
FUNCTION compute_sql_id (sql_text IN CLOB)
RETURN VARCHAR2 IS
 BASE_32 CONSTANT VARCHAR2(32) := '0123456789abcdfghjkmnpqrstuvwxyz';
 l_raw_128 RAW(128);
 l_hex_32 VARCHAR2(32);
 l_low_16 VARCHAR(16);
 l_q3 VARCHAR2(8);
 l_q4 VARCHAR2(8);
 l_low_16_m VARCHAR(16);
 l_number NUMBER;
 l_idx INTEGER;
 l_sql_id VARCHAR2(13);
BEGIN
 l_raw_128 := /* use md5 algorithm on sql_text and produce 128 bit hash */
 SYS.DBMS_CRYPTO.hash(TRIM(CHR(0) FROM sql_text)||CHR(0), SYS.DBMS_CRYPTO.hash_md5);
 l_hex_32 := RAWTOHEX(l_raw_128); /* 32 hex characters */
 l_low_16 := SUBSTR(l_hex_32, 17, 16); /* we only need lower 16 */
 l_q3 := SUBSTR(l_low_16, 1, 8); /* 3rd quarter (8 hex characters) */
 l_q4 := SUBSTR(l_low_16, 9, 8); /* 4th quarter (8 hex characters) */
 /* need to reverse order of each of the 4 pairs of hex characters */
 l_q3 := SUBSTR(l_q3, 7, 2)||SUBSTR(l_q3, 5, 2)||SUBSTR(l_q3, 3, 2)||SUBSTR(l_q3, 1, 2);
 l_q4 := SUBSTR(l_q4, 7, 2)||SUBSTR(l_q4, 5, 2)||SUBSTR(l_q4, 3, 2)||SUBSTR(l_q4, 1, 2);
 /* assembly back lower 16 after reversing order on each quarter */
 l_low_16_m := l_q3||l_q4;
 /* convert to number */
 SELECT TO_NUMBER(l_low_16_m, 'xxxxxxxxxxxxxxxx') INTO l_number FROM DUAL;
 /* 13 pieces base-32 (5 bits each) make 65 bits. we do have 64 bits */
 FOR i IN 1 .. 13
 LOOP
 l_idx := TRUNC(l_number / POWER(32, (13 - i))); /* index on BASE_32 */
 l_sql_id := l_sql_id||SUBSTR(BASE_32, (l_idx + 1), 1); /* stitch 13 characters */
 l_number := l_number - (l_idx * POWER(32, (13 - i))); /* for next piece */
 END LOOP;
 RETURN l_sql_id;
END compute_sql_id;
SELECT PLAN_NAME --,compute_sql_id(sql_text) sql_id --, signature,PLAN_NAME
  FROM dba_sql_plan_baselines where compute_sql_id(sql_text)='f47hwh66apz08'
;