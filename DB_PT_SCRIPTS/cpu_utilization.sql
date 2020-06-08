set line 400
col METRIC_NAME for a70
col BEGIN_TIME for a20
col END_TIME for a20

select to_char( BEGIN_TIME, 'DD-MM-YYYY HH24:MI:SS' ) BEGIN_TIME,to_char( END_TIME, 'DD-MM-YYYY HH24:MI:SS' ) END_TIME,METRIC_NAME,MINVAL,MAXVAL,AVERAGE from DBA_HIST_SYSMETRIC_SUMMARY where SNAP_ID > ( select max(snap_id)-3 from DBA_HIST_RESOURCE_LIMIT) and METRIC_NAME in ('Host CPU Utilization (%)','Process Limit %')  order by 1;

select  METRIC_NAME,VALUE from v$sysmetric where METRIC_NAME in ('Current OS Load','Database Wait Time Ratio','Database CPU Time Ratio');