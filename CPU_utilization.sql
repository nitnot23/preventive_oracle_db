set linesize 1000
set pagesize 1000
col begin_interval_time for a30
col end_interval_time for a30

select hss.snap_id, hs.begin_interval_time, hs.end_interval_time,
hss.instance_number,round(hss.maxval,2) as MAXVAL, round(hss.average,2) as AVG
from DBA_HIST_SYSMETRIC_SUMMARY hss, dba_hist_snapshot hs
WHERE hss.snap_id = hs.snap_id 
AND hss.metric_name ='Host CPU Utilization (%)'
ORDER BY hs.begin_interval_time;
