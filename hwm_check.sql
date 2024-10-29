To know HWM:

select
            tablespace_name,
            file_id,
            file_name DATA_FILE_NAME,
            Allocated_MBYTES,
            High_Water_Mark_MBYTES,
            FREE_MBYTES,
            trunc((FREE_MBYTES/Allocated_MBYTES)*100,2) "% Free",
            trunc(Allocated_MBYTES-High_Water_Mark_MBYTES,2) Resizeble
   from
   (
      select
           ddf.tablespace_name tablespace_name,
           ddf.file_id file_id,
           ddf.file_name file_name,
           ddf.bytes/1024/1024 Allocated_MBYTES,
           trunc((ex.hwm*(dt.block_size))/1024/1024,2) High_Water_Mark_MBYTES,
           FREE_MBYTES
      from
           dba_data_files ddf,
           dba_tablespaces dt,
      (
           select file_id, sum(bytes/1024/1024) FREE_MBYTES
           from dba_free_space
           group by file_id
      ) free,
      (
           select file_id, max(block_id+blocks) hwm
           from dba_extents
           group by file_id
      ) ex
      where ddf.file_id = ex.file_id
      and ddf.tablespace_name = dt.tablespace_name
      and ddf.file_id = free.file_id (+)
      order by ddf.tablespace_name, ddf.file_id
    );
