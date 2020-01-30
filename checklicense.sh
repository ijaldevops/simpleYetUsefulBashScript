#!/bin/bash

sqlplus -s / as sysdba << EOF


SET LINESIZE 150

COL name FORM A30


SELECT MIN(id) min_id,
    MAX(id) max_id,
    COUNT(*) total_devices,
    SUM(CASE WHEN status = 1 THEN 1 ELSE 0 END) revoked_devices,
    SUM(CASE WHEN SYSDATE BETWEEN notbefore AND notafter THEN 0 ELSE 1 END) expired_devices,
    SUM(CASE WHEN (status = 0 AND SYSDATE BETWEEN notbefore AND notafter) OR (CAST(statustimestamp AS DATE) + 24/24 > SYSDATE) THEN 1 ELSE 0 END) active_devices
FROM iptv.CLIENTDEVICE;

EXIT;

EOF
