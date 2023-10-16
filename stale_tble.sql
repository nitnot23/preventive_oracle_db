select owner,
sum(decode(stale_stats, 'YES', 1,0)) STALE,
sum(decode(stale_stats, 'NO', 1,0)) NO_STALE,
sum(decode(stale_stats, null, 1,0)) NULL_STALE
from DBA_TAB_STATISTICS
where object_type='TABLE'
group by owner;
