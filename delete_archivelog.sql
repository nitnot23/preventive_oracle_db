-- Delete Archivelog --
set serveroutput on
BEGIN
rdsadmin.rdsadmin_rman_util.crosscheck_archivelog(
p_delete_expired => TRUE,
p_rman_to_dbms_output => FALSE);
END;
/
