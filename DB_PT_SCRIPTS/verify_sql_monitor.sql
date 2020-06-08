SELECT DBMS_SQLTUNE.report_sql_monitor(type => 'TEXT', report_level=>'ALL', SQL_ID=>'&1') AS REPORT FROM DUAL;
