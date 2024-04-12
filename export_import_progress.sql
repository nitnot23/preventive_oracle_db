SELECT OPNAME, SID, SERIAL#, CONTEXT, SOFAR, TOTALWORK, ROUND(SOFAR/TOTALWORK*100,2) "%_COMPLETE"
FROM V$SESSION_LONGOPS WHERE OPNAME in
( select d.job_name from v$session s, v$process p, dba_datapump_sessions d
where p.addr=s.paddr and s.saddr=d.saddr )
AND OPNAME NOT LIKE '%aggregate%' AND 
TOTALWORK != 0 AND SOFAR <> TOTALWORK;

SELECT owner_name, job_name, operation, job_mode, state 
FROM dba_datapump_jobs
where state='EXECUTING';
