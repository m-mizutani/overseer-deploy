-- title: Detect flow logs with IoC from abuse.ch Feodo Tracker
-- limit: 10

WITH
  ioc AS (
  SELECT
    as_name,
    ip_address
  FROM
    `mztn-dep.pacman.abusech_feodo` )
SELECT
  DISTINCT logs.src_addr,
  logs.dst_addr,
  logs.first_seen_at,
  ioc.as_name AS threat_name,
  ioc.ip_address AS ioc_addr
FROM
  `mztn-dep.devourer_home.flow_logs` AS logs
INNER JOIN
  ioc
ON
  logs.src_addr = ioc.ip_address
  OR logs.dst_addr = ioc.ip_address
WHERE
  first_seen_at >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 2 DAY)
LIMIT
  10
