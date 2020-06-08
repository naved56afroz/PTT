		set pages 500 lines 300
		column machine format a30
		column event format a30
		column sid format 99999
		column running_in_mins heading "Running|In_mins"
		col username format a15
		col sql_id format a16
		col prev_sql_id format a16
		col spid format a10
		col status format a10
		col module format a25
		col service_name format a15
		select
				a.INST_ID,
				a.username,
				a.machine,
				a.status,
				a.sid,
				a.SERIAL#,
				c.spid,
				a.sql_id ,
				a.prev_sql_id,
				substr(a.event ,1,30) event,
				round(a.last_call_et/60,2) running_in_mins ,
				a.p1
		--        a.service_name
		--      substr(a.module,1,25) Module
		from
				gv$session a,
				gv$process c
		where
				a.paddr = c.addr and
				--a.sid=97 --and
				--a.machine='pepldr00942' and
			   --a.status = 'ACTIVE' and
				--a.sql_id in ('fq9azkhu3c4y6','5j5t3app9bs1f','7z3sm7tk5n8d2','9qp3p72h9h791') and
				--a.sql_id in ('898nmvtpfcqsq') and
				--a.sql_id in ('2hxg8rf58b4pa','2s08m7x87rx6c') and
				--a.username ='MUSER' and
				a.username not in ('SYSTEM','SYS','DBSNMP','A_ORAAUDIT_I') and
				a.username is not null
		order by running_in_mins;