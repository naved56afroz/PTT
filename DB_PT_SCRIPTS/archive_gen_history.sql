set pages 1000 lines 200
column 00 for a4
column 01 for a4
column 02 for a4
column 03 for a4
column 04 for a4
column 05 for a4
column 06 for a6
column 07 for a6
column 08 for a4
column 09 for a4
column 10 for a4
column 11 for a4
column 12 for a4
column 13 for a4
column 14 for a4
column 15 for a4
column 16 for a4
column 17 for a4
column 18 for a4
column 19 for a4
column 20 for a4
column 21 for a4
column 22 for a4
column 23 for a4
SELECT to_date(first_time) DAY,
to_char(sum(decode(to_char(first_time,'HH24'),'00',1,0)),'999') "00",
to_char(sum(decode(to_char(first_time,'HH24'),'01',1,0)),'999') "01",
to_char(sum(decode(to_char(first_time,'HH24'),'02',1,0)),'999') "02",
to_char(sum(decode(to_char(first_time,'HH24'),'03',1,0)),'999') "03",
to_char(sum(decode(to_char(first_time,'HH24'),'04',1,0)),'999') "04",
to_char(sum(decode(to_char(first_time,'HH24'),'05',1,0)),'999') "05",
to_char(sum(decode(to_char(first_time,'HH24'),'06',1,0)),'999') "06",
to_char(sum(decode(to_char(first_time,'HH24'),'07',1,0)),'999') "07",
to_char(sum(decode(to_char(first_time,'HH24'),'08',1,0)),'999') "08",
to_char(sum(decode(to_char(first_time,'HH24'),'09',1,0)),'999') "09",
to_char(sum(decode(to_char(first_time,'HH24'),'10',1,0)),'999') "10",
to_char(sum(decode(to_char(first_time,'HH24'),'11',1,0)),'999') "11",
to_char(sum(decode(to_char(first_time,'HH24'),'12',1,0)),'999') "12",
to_char(sum(decode(to_char(first_time,'HH24'),'13',1,0)),'999') "13",
to_char(sum(decode(to_char(first_time,'HH24'),'14',1,0)),'999') "14",
to_char(sum(decode(to_char(first_time,'HH24'),'15',1,0)),'999') "15",
to_char(sum(decode(to_char(first_time,'HH24'),'16',1,0)),'999') "16",
to_char(sum(decode(to_char(first_time,'HH24'),'17',1,0)),'999') "17",
to_char(sum(decode(to_char(first_time,'HH24'),'18',1,0)),'999') "18",
to_char(sum(decode(to_char(first_time,'HH24'),'19',1,0)),'999') "19",
to_char(sum(decode(to_char(first_time,'HH24'),'20',1,0)),'999') "20",
to_char(sum(decode(to_char(first_time,'HH24'),'21',1,0)),'999') "21",
to_char(sum(decode(to_char(first_time,'HH24'),'22',1,0)),'999') "22",
to_char(sum(decode(to_char(first_time,'HH24'),'23',1,0)),'999') "23",
COUNT(*) TOT  
from
v$log_history
where to_date(first_time) > sysdate -30
GROUP by
to_char(first_time,'YYYY-MON-DD'), to_date(first_time)
order by to_date(first_time)
/  

