-- =========================================================
-- Task 3.3: Hand the team a corrected query
-- Three Equivalent Forms
-- =========================================================

-- Question:
-- Which riders have never taken a trip?


-- ---------------------------------------------------------
-- Form 1: Subquery using NOT IN
-- ---------------------------------------------------------

SELECT
    rider_id,
    rider_name
FROM riders
WHERE rider_id NOT IN (
    SELECT rider_id
    FROM trips
)
ORDER BY rider_id;


-- ---------------------------------------------------------
-- Form 2: Common Table Expression (CTE) using WITH
-- ---------------------------------------------------------

WITH riders_with_trips AS (
    SELECT DISTINCT rider_id
    FROM trips
)
SELECT
    r.rider_id,
    r.rider_name
FROM riders AS r
LEFT JOIN riders_with_trips AS t
    ON r.rider_id = t.rider_id
WHERE t.rider_id IS NULL
ORDER BY r.rider_id;


-- ---------------------------------------------------------
-- Form 3: LEFT JOIN ... IS NULL
-- ---------------------------------------------------------

SELECT
    r.rider_id,
    r.rider_name
FROM riders AS r
LEFT JOIN trips AS t
    ON r.rider_id = t.rider_id
WHERE t.rider_id IS NULL
ORDER BY r.rider_id;


-- ---------------------------------------------------------
-- Verification:
-- Demonstrate that the rows themselves match, not just
-- that the three queries return the same row count.
--
-- EXCEPT returns rows that appear in one result set but
-- not the other. A result of 0 rows demonstrates that
-- there are no differences between the result sets.
-- ---------------------------------------------------------

WITH
form1 AS (
    SELECT
        rider_id,
        rider_name
    FROM riders
    WHERE rider_id NOT IN (
        SELECT rider_id
        FROM trips
    )
),

form2 AS (
    WITH riders_with_trips AS (
        SELECT DISTINCT rider_id
        FROM trips
    )
    SELECT
        r.rider_id,
        r.rider_name
    FROM riders AS r
    LEFT JOIN riders_with_trips AS t
        ON r.rider_id = t.rider_id
    WHERE t.rider_id IS NULL
),

form3 AS (
    SELECT
        r.rider_id,
        r.rider_name
    FROM riders AS r
    LEFT JOIN trips AS t
        ON r.rider_id = t.rider_id
    WHERE t.rider_id IS NULL
)

SELECT 'Form 1 minus Form 2' AS comparison, COUNT(*) AS different_rows
FROM (
    SELECT * FROM form1
    EXCEPT
    SELECT * FROM form2
) AS diff

UNION ALL

SELECT 'Form 2 minus Form 1', COUNT(*)
FROM (
    SELECT * FROM form2
    EXCEPT
    SELECT * FROM form1
) AS diff

UNION ALL

SELECT 'Form 1 minus Form 3', COUNT(*)
FROM (
    SELECT * FROM form1
    EXCEPT
    SELECT * FROM form3
) AS diff

UNION ALL

SELECT 'Form 3 minus Form 1', COUNT(*)
FROM (
    SELECT * FROM form3
    EXCEPT
    SELECT * FROM form1
) AS diff;


-- ---------------------------------------------------------
-- Equivalence condition
-- ---------------------------------------------------------
-- These three forms are equivalent for the current dataset
-- because trips.rider_id does not contain NULL values.
--
-- If trips.rider_id contained a NULL, the NOT IN form could
-- behave differently because comparisons involving NULL
-- evaluate to UNKNOWN. The CTE and LEFT JOIN forms would
-- still identify riders with no matching trip.