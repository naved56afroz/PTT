DECLARE
 CUR SYS_REFCURSOR;
 BEGIN
 OPEN CUR FOR
 SELECT VALUE(P) FROM TABLE ( DBMS_SQLTUNE.SELECT_WORKLOAD_REPOSITORY(BEGIN_SNAP=>&1, END_SNAP=>&2, BASIC_FILTER=> 'sql_id = ''&3''', ATTRIBUTE_LIST=>'ALL' )) p;
 DBMS_SQLTUNE.LOAD_SQLSET(SQLSET_NAME=> '&4', POPULATE_CURSOR=>CUR);
 CLOSE CUR;
 END;
 /