set line 400 pages 0 long 9999
SELECT *
    FROM all_source
   WHERE TYPE = 'PACKAGE BODY' AND name = '&1'
ORDER BY line;