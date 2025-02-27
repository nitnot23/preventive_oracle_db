SELECT   A.VALUE,
    S.USERNAME,
    S.SID,
    S.SERIAL#
  FROM V$SESSTAT A,
    V$STATNAME B,
    V$SESSION S
  WHERE A.STATISTIC# = B.STATISTIC#
    AND S.SID        = A.SID
    AND B.NAME       = 'opened cursors current';

select * from V$PARAMETER where name='session_cached_cursors';

SELECT max(a.value) as highest_open_cur, p.value as max_open_cur FROM v$sesstat a, v$statname b, v$parameter p 
WHERE a.statistic# = b.statistic# AND b.name = 'opened cursors current' AND p.name= 'open_cursors'  GROUP BY p.value;

SELECT a.value, s.username, s.sid, s.serial#, s.status
 FROM v$sesstat a, v$statname b, v$session s
 WHERE a.statistic# = b.statistic#  AND s.sid=a.sid 
 AND b.name = 'opened cursors current' order by value desc;

 
 SELECT oc.sql_text, s.sid 
 FROM v$open_cursor oc, v$session s
 WHERE OC.sid = S.sid
 AND OC.USER_NAME ='NIPROPRD';
