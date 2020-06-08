set line 400 long 9999 pages 200
select address,hash_value,loads,parse_calls,executions,buffer_gets,disk_reads, buffer_gets/decode(executions,0,1,executions) avg_read ,disk_reads/decode(executions,0,1,executions) avg_pread,rows_processed
,sql_text from v$sqlarea
where  sql_id='&sql_id';
