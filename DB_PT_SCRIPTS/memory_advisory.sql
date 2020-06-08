set colsep '|'
 
select decode( grouping(nm), 1, 'total', nm ) nm, round(sum(val/1024/1024)) mb
from
(
select 'sga' nm, sum(value) val
from v$sga
union all
select 'pga', sum(a.value)
from v$sesstat a, v$statname b
where b.name = 'session pga memory'
and a.statistic# = b.statistic#
)
group by rollup(nm);

SELECT sga_size/1024 "sga_size GB", sga_size_factor, estd_db_time_factor
FROM v$sga_target_advice
ORDER BY sga_size ASC;

select pga_target_for_estimate/1024/1024/1024 "pga_target_for_estimate GB", pga_target_factor, estd_time
from v$pga_target_advice;
