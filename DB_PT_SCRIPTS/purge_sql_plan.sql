set serveroutput on
declare
name varchar2(50);
v_count number := 0;
sqlid V$SQLAREA.SQL_Id%TYPE;
begin
sqlid :='&1';
--dbms_output.put_line ('sql '||sqlid );
select address||','||hash_value into name from v$sqlarea where sql_id = sqlid;
dbms_output.put_line (' ADD '|| name);
dbms_shared_pool.purge(name,'C',1);
select count(*) into v_count from V$SQLAREA where SQL_Id=sqlid;
  if v_count = 0 then
      dbms_output.put_line ('sql has been purged SUCCESSFULLY..');
  else
      dbms_output.put_line ('sql has did not got purged , kindly check manually..');
  end if;
end;
/
