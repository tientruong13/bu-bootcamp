-- 3.1a Active, highly rated drivers — the producers whose records
-- anchor the audit. Requirement: SELECT, WHERE, ORDER BY, LIMIT.
SELECT driver_id, driver_name, avg_rating
FROM drivers
WHERE is_active = TRUE
  AND avg_rating >= 4.5
ORDER BY avg_rating DESC
LIMIT 10;


-- 3.1b Find all possible trip statuses.
-- Requirement: DISTINCT.
SELECT DISTINCT trip_status
FROM trips
ORDER BY trip_status;


-- 3.1c Filter trips using a numeric range.
-- Requirement: numeric range using BETWEEN.
SELECT trip_id, rider_id, driver_id, fare_amount
FROM trips
WHERE fare_amount BETWEEN 20 AND 40
ORDER BY fare_amount;


-- 3.1c Filter trips using an explicit list of values.
-- Requirement: IN.
SELECT trip_id, rider_id, driver_id, trip_status
FROM trips
WHERE trip_status IN ('completed', 'disputed')
ORDER BY driver_id, trip_id;


-- 3.1d Find drivers whose names match a text pattern.
-- Requirement: LIKE.
SELECT driver_id, driver_name
FROM drivers
WHERE driver_name LIKE 'Driver_1%'
ORDER BY driver_id;


-- 3.1d Find trips where the cancellation reason is missing.
-- Requirement: NULL using IS NULL.
SELECT trip_id, trip_status, cancellation_reason
FROM trips
WHERE cancellation_reason IS NULL
LIMIT 10;


-- 3.1d Replace missing cancellation reasons with a useful label.
-- Requirement: COALESCE.
SELECT trip_id,
       trip_status,
       COALESCE(cancellation_reason, 'No reason provided') AS cancellation_reason
FROM trips
LIMIT 10;


-- 3.1e Calculate the final fare and label each trip by fare category.
-- Requirement: calculated column and CASE.
SELECT trip_id,
       fare_amount,
       surge_multiplier,
       ROUND(fare_amount * surge_multiplier, 2) AS final_fare,
       CASE
           WHEN fare_amount * surge_multiplier < 25 THEN 'Low fare'
           WHEN fare_amount * surge_multiplier < 50 THEN 'Medium fare'
           ELSE 'High fare'
       END AS fare_category
FROM trips
ORDER BY trip_id
LIMIT 10;