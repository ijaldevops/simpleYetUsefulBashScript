
#-- ============================================================================
#-- Author      : Sinardy
#-- Last Change : 4 Feb 2015
#-- Version     : 1.0
#-- Description : - To check FRA usage and the RECOVERY DEST sizing
#--               - Compatible for RAC and non RAC
#--
#-- Change Hist : Initial version
#--
#-- Copyright (c) 2015, Verimatrix and/or its affiliates. All rights reserved.                          
#-- ============================================================================

sqlplus -s / as sysdba << EOF


-- Utilisation (MB) du FRA
SET LINESIZE 150
SET FEEDBACK OFF
COL name FORM A30

PROMPT Following is the logical setup, check if physical is supporting this size.

SELECT name, FLOOR(space_limit / 1024 / 1024 / 1024) "Size GB",
       CEIL(space_used / 1024 / 1024 / 1024) "Used GB"
FROM v\$recovery_file_dest;


-- FRA Occupants
SELECT * FROM V\$FLASH_RECOVERY_AREA_USAGE;


-- Location and size of the FRA
show parameter db_recovery_file_dest


-- Size, used, Reclaimable
SELECT
  ROUND((a.space_limit / 1024 / 1024 / 1024), 2) AS FLASH_IN_GB,
  ROUND((a.space_used / 1024 / 1024 / 1024), 2) AS FLASH_USED_IN_GB,
  ROUND((a.space_reclaimable / 1024 / 1024 / 1024), 2) AS FLASH_RECLAIMABLE_GB,
  SUM(b.percent_space_used)  AS PERCENT_OF_SPACE_USED
FROM
  v\$recovery_file_dest a,
  v\$flash_recovery_area_usage b
GROUP BY
  space_limit,
  space_used ,
  space_reclaimable;

EXIT;

EOF