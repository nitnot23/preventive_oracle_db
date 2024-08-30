-- List Partition Name --

select owner,object_name, subobject_name, created
from dba_objects
where object_type like '%PARTITION%' and owner = 'UPF_ADMIN' 
and subobject_name in 
        (select partition_name from dba_tab_partitions where table_owner = 'UPF_ADMIN' /*and table_name in ('IPF_TRANS_LOG','IPF_MESSAGE','IPF_ALIAS_MGMT_LOG')*/ )
order by created desc;
