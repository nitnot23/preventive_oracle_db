select TO_CHAR(run_time,'MM-YYYY') bulan, name, sum(variance) grow_monthly
from (
with t as (
select ss.run_time,ts.name,round(su.tablespace_size*dt.block_size/1024/1024/1024,2) alloc_size_gb, round(su.tablespace_usedsize*dt.block_size/1024/1024/1024,2) used_size_gb
from
dba_hist_tbspc_space_usage su,
(select trunc(BEGIN_INTERVAL_TIME) run_time,max(snap_id) snap_id from dba_hist_snapshot
group by trunc(BEGIN_INTERVAL_TIME) ) ss,
v$tablespace ts,
dba_tablespaces dt
where su.snap_id = ss.snap_id
and su.tablespace_id = ts.ts#
and ts.name = dt.tablespace_name
and ts.name not in ('UNDOTBS1','UNDOTBS2','TEMP','SYSTEM','SYSAUX', 'USERS')  )
select e.run_time,e.name,e.alloc_size_gb,e.used_size_gb curr_used_size_gb,b.used_size_gb prev_used_size_gb,
case when e.used_size_gb > b.used_size_gb then e.used_size_gb - b.used_size_gb
when e.used_size_gb = b.used_size_gb then 0 when e.used_size_gb < b.used_size_gb then null end variance
from t e, t b
where e.run_time = b.run_time +1
order by 1 )
group by TO_CHAR(run_time,'MM-YYYY'), name;
