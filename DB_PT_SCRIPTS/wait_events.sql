set line 400 pages 50
col wait_class for a30
col EVENT for a70
Select c.wait_class,a.event, a.total_waits, a.time_waited, a.average_wait
From v$system_event a, v$event_name b, v$system_wait_class c
Where a.event_id=b.event_id
And b.wait_class#=c.wait_class#
And c.wait_class in ( select wait_class from (Select wait_class, sum(time_waited), sum(time_waited)/sum(total_waits)
Sum_Waits
From v$system_wait_class
Group by wait_class
Order by 3 desc) where rownum <=3)
order by average_wait desc;
