-- title: Detect flow logs with IoC from OTX pulses
-- limit: 10
WITH
  ioc AS (
  SELECT
    indicator.indicator as ip_address,
    indicator.description as description
  FROM
    `mztn-dep.pacman.otx_pulses` AS pulse,
    UNNEST(indicators) AS indicator
  WHERE
    indicator.type = "IPv4" )
SELECT
  DISTINCT logs.src_addr,
  logs.dst_addr,
  logs.first_seen_at,
  ioc.description,
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
