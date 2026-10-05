-- Task 3.2 Part A: The rows that vanished
-- Demonstrate how a comparison against a nullable column can silently
-- omit rows because SQL treats comparisons with NULL as UNKNOWN.


-- 3.2A-1 Broken query
-- Question: How many trips have a cancellation reason other than
-- 'Rider no show'?
-- This query incorrectly excludes rows where cancellation_reason is NULL.
SELECT COUNT(*) AS broken_count
FROM trips
WHERE cancellation_reason <> 'Rider no show';


-- 3.2A-2 Count the rows silently omitted by the broken query
-- Question: How many trips have a missing cancellation reason?
SELECT COUNT(*) AS omitted_null_rows
FROM trips
WHERE cancellation_reason IS NULL;


-- 3.2A-3 Repair the broken query
-- Question: How many trips are not 'Rider no show', including trips
-- where no cancellation reason was provided?
SELECT COUNT(*) AS repaired_count
FROM trips
WHERE cancellation_reason <> 'Rider no show'
   OR cancellation_reason IS NULL;


-- 3.2A-4 Verify the counts against the full table
-- Broken = 22, omitted NULL rows = 166,
-- repaired = 188, total = 200.
SELECT
    COUNT(*) FILTER (
        WHERE cancellation_reason <> 'Rider no show'
    ) AS broken_count,

    COUNT(*) FILTER (
        WHERE cancellation_reason IS NULL
    ) AS omitted_null_rows,

    COUNT(*) FILTER (
        WHERE cancellation_reason <> 'Rider no show'
           OR cancellation_reason IS NULL
    ) AS repaired_count,

    COUNT(*) AS total_rows
FROM trips;

-- =========================================================
-- Task 3.2 Part B: The alias that did not exist yet
-- =========================================================

-- Broken query:
-- Question: Which trips have a final fare greater than $30?
-- This query fails because final_fare is a SELECT alias.
-- WHERE is evaluated before SELECT, so the alias does not
-- exist when the WHERE clause is evaluated.

--SELECT
--    trip_id,
--    fare_amount,
--    surge_multiplier,
--    ROUND(fare_amount * surge_multiplier, 2) AS final_fare
--FROM trips
--WHERE final_fare > 30;

-- PostgreSQL error message:
-- ERROR:  column "final_fare" does not exist
-- LINE 7: WHERE final_fare > 30;
--               ^


-- Rewrite 1:
-- Repeat the calculated expression directly in WHERE.

SELECT
    trip_id,
    fare_amount,
    surge_multiplier,
    ROUND(fare_amount * surge_multiplier, 2) AS final_fare
FROM trips
WHERE ROUND(fare_amount * surge_multiplier, 2) > 30
ORDER BY final_fare;


-- Rewrite 2:
-- Use a CTE so final_fare is created before the outer
-- WHERE clause evaluates it.

WITH trip_fares AS (
    SELECT
        trip_id,
        fare_amount,
        surge_multiplier,
        ROUND(fare_amount * surge_multiplier, 2) AS final_fare
    FROM trips
)
SELECT
    trip_id,
    fare_amount,
    surge_multiplier,
    final_fare
FROM trip_fares
WHERE final_fare > 30
ORDER BY final_fare;