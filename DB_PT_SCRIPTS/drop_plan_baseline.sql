SET SERVEROUTPUT ON
DECLARE
l_plans_dropped  PLS_INTEGER;
BEGIN
l_plans_dropped := DBMS_SPM.drop_sql_plan_baseline (
sql_handle => NULL,
plan_name  => '&1');
DBMS_OUTPUT.put_line('Plan has been dropped SUCCESSFULLY :'||l_plans_dropped);
END;
/
