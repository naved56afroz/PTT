set pages 1000 lines 210
col table_name for a30
col column_name for a30
col r_owner for a8
SELECT c.owner, a.table_name, a.column_name, a.constraint_name,  
       c.r_owner, c_pk.table_name r_table_name, c_pk.constraint_name r_pk, c.status
  FROM all_cons_columns a
  JOIN all_constraints c ON a.owner = c.owner
                        AND a.constraint_name = c.constraint_name
  JOIN all_constraints c_pk ON c.r_owner = c_pk.owner
                           AND c.r_constraint_name = c_pk.constraint_name
 WHERE c.constraint_type = 'R'
   AND a.table_name = upper('&1');
