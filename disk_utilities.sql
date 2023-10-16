COL NAME FOR A15
SELECT NAME,TOTAL_MB,FREE_MB,USABLE_FILE_MB,STATE FROM V$ASM_DISKGROUP;
##
set pagesize 200
set linesize 200
COL NAME FOR A15
SELECT NAME,TOTAL_MB,FREE_MB,USABLE_FILE_MB,USABLE_FILE_MB/TOTAL_MB*100 as "%USED",FREE_MB/TOTAL_MB*100 as "%Free",STATE FROM V$ASM_DISKGROUP;
##
set pagesize 200
set linesize 200
COL NAME FOR A15
SELECT NAME,TOTAL_MB,FREE_MB,USABLE_FILE_MB,USABLE_FILE_MB/TOTAL_MB*100 as "%USED",FREE_MB/TOTAL_MB*100 as "%Free",STATE FROM V$ASM_DISKGROUP;
##
COL NAME FOR A40;
COL PATH FOR A40;
SELECT NAME,MOUNT_STATUS,TOTAL_MB,FREE_MB,PATH FROM V$ASM_DISK ORDER BY 1;
##
set pagesize 200
set linesize 200
col name format a13
col REDUNDANCY format a12
col state format a7
select
GROUP_NUMBER,name,
round((total_mb/decode(type,'NORMAL',2,'HIGH',3,'EXTERN',1))/1024) Total_GB,
round(usable_file_mb/1024) usable_free_gb,
round((hot_used_mb+cold_used_mb)/decode(type,'NORMAL',2,'HIGH',3,1)/1024) data_use_gb,
round((free_mb/decode(type,'NORMAL',2,'HIGH',3,'EXTERN',1))/1024) Free_GB,
round(required_mirror_free_mb/decode(type,'NORMAL',2,'HIGH',3,1)/1024) req_free_redun_gb,
type "REDUNDANCY",state,
round(((free_mb/decode(type,'NORMAL',2,'HIGH',3,'EXTERN',1))/(total_mb/decode(type,'NORMAL',2,'HIGH',3,'EXTERN',1)))*100,2) "%Free"
from v$asm_diskgroup;
