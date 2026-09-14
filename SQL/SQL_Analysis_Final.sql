-- ============================================================
-- Clinical Trials Precision Oncology
-- SQL Analysis Portfolio
-- Database: MySQL
-- ============================================================


-- ============================================================
-- 1. DATABASE SETUP
-- ============================================================

CREATE DATABASE IF NOT EXISTS ctpo;

USE ctpo;

SELECT DATABASE();


-- ============================================================
-- 2. TABLE CREATION
-- ============================================================

CREATE TABLE IF NOT EXISTS clinical_trials (
    nct_id VARCHAR(20),
    title TEXT,
    matched_condition VARCHAR(255),
    overall_status VARCHAR(100),
    why_stopped TEXT,
    start_date_raw VARCHAR(50),
    completion_date_raw VARCHAR(50),
    lead_sponsor TEXT,
    sponsor_class VARCHAR(100),
    collaborators_raw TEXT,
    conditions_raw TEXT,
    phase_raw VARCHAR(100),
    study_type VARCHAR(100),
    enrollment_count INT,
    eligibility_criteria LONGTEXT,
    minimum_age VARCHAR(50),
    maximum_age VARCHAR(50),
    sex VARCHAR(20),
    locations_raw LONGTEXT,
    start_date DATE,
    completion_date DATE,
    detected_biomarkers TEXT,
    detected_alterations TEXT,
    gene_alteration_matches TEXT
);

DESCRIBE clinical_trials;


-- ============================================================
-- 3. DATA VALIDATION
-- ============================================================

-- Total number of rows
SELECT
    COUNT(*) AS total_rows
FROM clinical_trials;


-- Number of unique clinical trials
-- COUNT(DISTINCT) is used because one trial can have
-- multiple matched-condition rows.
SELECT
    COUNT(DISTINCT nct_id) AS unique_trials
FROM clinical_trials;


-- Check for missing NCT IDs
SELECT
    COUNT(*) AS missing_nct_ids
FROM clinical_trials
WHERE nct_id IS NULL
   OR nct_id = '';


-- Check missing important fields
SELECT
    SUM(overall_status IS NULL OR overall_status = '') AS missing_status,
    SUM(study_type IS NULL OR study_type = '') AS missing_study_type,
    SUM(phase_raw IS NULL OR phase_raw = '') AS missing_phase,
    SUM(enrollment_count IS NULL) AS missing_enrollment
FROM clinical_trials;


-- Check repeated NCT IDs
SELECT
    nct_id,
    COUNT(*) AS row_count
FROM clinical_trials
GROUP BY nct_id
HAVING COUNT(*) > 1
ORDER BY row_count DESC
LIMIT 10;


-- ============================================================
-- 4. OVERALL TRIAL ANALYSIS
-- ============================================================

-- Trial status distribution

SELECT
    overall_status,
    COUNT(DISTINCT nct_id) AS trial_count
FROM clinical_trials
GROUP BY overall_status
ORDER BY trial_count DESC;


-- Study type distribution

SELECT
    study_type,
    COUNT(DISTINCT nct_id) AS trial_count
FROM clinical_trials
GROUP BY study_type
ORDER BY trial_count DESC;


-- Clinical phase distribution

SELECT
    phase_raw,
    COUNT(DISTINCT nct_id) AS trial_count
FROM clinical_trials
GROUP BY phase_raw
ORDER BY trial_count DESC;


-- ============================================================
-- 5. BIOMARKER ANALYSIS
-- ============================================================

-- Trials containing at least one detected biomarker

SELECT
    COUNT(DISTINCT nct_id) AS biomarker_positive_trials
FROM clinical_trials
WHERE detected_biomarkers IS NOT NULL
  AND detected_biomarkers <> '[]';


-- EGFR-associated trials

SELECT
    COUNT(DISTINCT nct_id) AS egfr_trials
FROM clinical_trials
WHERE detected_biomarkers LIKE '%EGFR%';


-- ALK-associated trials

SELECT
    COUNT(DISTINCT nct_id) AS alk_trials
FROM clinical_trials
WHERE detected_biomarkers LIKE '%ALK%';


-- HER2-associated trials

SELECT
    COUNT(DISTINCT nct_id) AS her2_trials
FROM clinical_trials
WHERE detected_biomarkers LIKE '%HER2%';


-- Compare EGFR, ALK and HER2

SELECT
    'EGFR' AS biomarker,
    COUNT(DISTINCT nct_id) AS trial_count
FROM clinical_trials
WHERE detected_biomarkers LIKE '%EGFR%'

UNION ALL

SELECT
    'ALK',
    COUNT(DISTINCT nct_id)
FROM clinical_trials
WHERE detected_biomarkers LIKE '%ALK%'

UNION ALL

SELECT
    'HER2',
    COUNT(DISTINCT nct_id)
FROM clinical_trials
WHERE detected_biomarkers LIKE '%HER2%'

ORDER BY trial_count DESC;


-- ============================================================
-- 6. BIOMARKER × TRIAL STATUS
-- ============================================================

-- EGFR vs Trial Status

SELECT
    overall_status,
    COUNT(DISTINCT nct_id) AS egfr_trials
FROM clinical_trials
WHERE detected_biomarkers LIKE '%EGFR%'
GROUP BY overall_status
ORDER BY egfr_trials DESC;


-- ALK vs Trial Status

SELECT
    overall_status,
    COUNT(DISTINCT nct_id) AS alk_trials
FROM clinical_trials
WHERE detected_biomarkers LIKE '%ALK%'
GROUP BY overall_status
ORDER BY alk_trials DESC;


-- HER2 vs Trial Status

SELECT
    overall_status,
    COUNT(DISTINCT nct_id) AS her2_trials
FROM clinical_trials
WHERE detected_biomarkers LIKE '%HER2%'
GROUP BY overall_status
ORDER BY her2_trials DESC;


-- ============================================================
-- 7. ALTERATION ANALYSIS
-- ============================================================

-- Trials containing at least one detected alteration

SELECT
    COUNT(DISTINCT nct_id) AS alteration_positive_trials
FROM clinical_trials
WHERE detected_alterations IS NOT NULL
  AND detected_alterations <> '[]';


-- Most common detected alteration combinations

SELECT
    detected_alterations,
    COUNT(DISTINCT nct_id) AS trial_count
FROM clinical_trials
WHERE detected_alterations IS NOT NULL
  AND detected_alterations <> '[]'
GROUP BY detected_alterations
ORDER BY trial_count DESC
LIMIT 10;


-- ============================================================
-- 8. GENE–ALTERATION ANALYSIS
-- ============================================================

-- Trials with detected gene–alteration matches

SELECT
    COUNT(DISTINCT nct_id) AS gene_alteration_positive_trials
FROM clinical_trials
WHERE gene_alteration_matches IS NOT NULL
  AND gene_alteration_matches <> '[]';


-- Most common gene–alteration matches

SELECT
    gene_alteration_matches,
    COUNT(DISTINCT nct_id) AS trial_count
FROM clinical_trials
WHERE gene_alteration_matches IS NOT NULL
  AND gene_alteration_matches <> '[]'
GROUP BY gene_alteration_matches
ORDER BY trial_count DESC
LIMIT 15;


-- ============================================================
-- 9. ENROLLMENT ANALYSIS
-- ============================================================

-- Overall enrollment statistics

SELECT
    AVG(enrollment_count) AS average_enrollment,
    MIN(enrollment_count) AS minimum_enrollment,
    MAX(enrollment_count) AS maximum_enrollment
FROM clinical_trials
WHERE enrollment_count IS NOT NULL;


-- Top 10 trials by enrollment

SELECT
    nct_id,
    title,
    enrollment_count
FROM clinical_trials
WHERE enrollment_count IS NOT NULL
GROUP BY nct_id, title, enrollment_count
ORDER BY enrollment_count DESC
LIMIT 10;


-- Enrollment by study type

SELECT
    study_type,
    COUNT(DISTINCT nct_id) AS trial_count,
    ROUND(AVG(enrollment_count), 2) AS average_enrollment,
    MAX(enrollment_count) AS maximum_enrollment
FROM clinical_trials
WHERE enrollment_count IS NOT NULL
GROUP BY study_type
ORDER BY average_enrollment DESC;


-- Enrollment by biomarker

SELECT
    'EGFR' AS biomarker,
    COUNT(DISTINCT nct_id) AS trial_count,
    ROUND(AVG(enrollment_count), 2) AS average_enrollment,
    MAX(enrollment_count) AS maximum_enrollment
FROM clinical_trials
WHERE detected_biomarkers LIKE '%EGFR%'
  AND enrollment_count IS NOT NULL

UNION ALL

SELECT
    'ALK',
    COUNT(DISTINCT nct_id),
    ROUND(AVG(enrollment_count), 2),
    MAX(enrollment_count)
FROM clinical_trials
WHERE detected_biomarkers LIKE '%ALK%'
  AND enrollment_count IS NOT NULL

UNION ALL

SELECT
    'HER2',
    COUNT(DISTINCT nct_id),
    ROUND(AVG(enrollment_count), 2),
    MAX(enrollment_count)
FROM clinical_trials
WHERE detected_biomarkers LIKE '%HER2%'
  AND enrollment_count IS NOT NULL

ORDER BY average_enrollment DESC;


-- ============================================================
-- 10. SPONSOR ANALYSIS
-- ============================================================

-- Top 10 lead sponsors

SELECT
    lead_sponsor,
    COUNT(DISTINCT nct_id) AS trial_count
FROM clinical_trials
WHERE lead_sponsor IS NOT NULL
  AND lead_sponsor <> ''
GROUP BY lead_sponsor
ORDER BY trial_count DESC
LIMIT 10;


-- Trial distribution by sponsor class

SELECT
    sponsor_class,
    COUNT(DISTINCT nct_id) AS trial_count
FROM clinical_trials
WHERE sponsor_class IS NOT NULL
  AND sponsor_class <> ''
GROUP BY sponsor_class
ORDER BY trial_count DESC;


-- ============================================================
-- 11. TIMELINE ANALYSIS
-- ============================================================

-- Clinical trial activity by start year

SELECT
    YEAR(start_date) AS start_year,
    COUNT(DISTINCT nct_id) AS trial_count
FROM clinical_trials
WHERE start_date IS NOT NULL
GROUP BY YEAR(start_date)
ORDER BY start_year;


-- ============================================================
-- 12. BIOMARKER × PHASE
-- ============================================================

SELECT
    phase_raw,

    COUNT(DISTINCT CASE
        WHEN detected_biomarkers LIKE '%EGFR%'
        THEN nct_id
    END) AS egfr_trials,

    COUNT(DISTINCT CASE
        WHEN detected_biomarkers LIKE '%ALK%'
        THEN nct_id
    END) AS alk_trials,

    COUNT(DISTINCT CASE
        WHEN detected_biomarkers LIKE '%HER2%'
        THEN nct_id
    END) AS her2_trials

FROM clinical_trials
GROUP BY phase_raw
ORDER BY phase_raw;


-- ============================================================
-- 13. BIOMARKER × STUDY TYPE
-- ============================================================

SELECT
    study_type,

    COUNT(DISTINCT CASE
        WHEN detected_biomarkers LIKE '%EGFR%'
        THEN nct_id
    END) AS egfr_trials,

    COUNT(DISTINCT CASE
        WHEN detected_biomarkers LIKE '%ALK%'
        THEN nct_id
    END) AS alk_trials,

    COUNT(DISTINCT CASE
        WHEN detected_biomarkers LIKE '%HER2%'
        THEN nct_id
    END) AS her2_trials

FROM clinical_trials
GROUP BY study_type
ORDER BY study_type;


-- ============================================================
-- 14. GENE–ALTERATION × STATUS
-- ============================================================

SELECT
    overall_status,
    COUNT(DISTINCT nct_id) AS gene_alteration_trials
FROM clinical_trials
WHERE gene_alteration_matches IS NOT NULL
  AND gene_alteration_matches <> '[]'
GROUP BY overall_status
ORDER BY gene_alteration_trials DESC;


-- ============================================================
-- 15. GENE–ALTERATION × PHASE
-- ============================================================

SELECT
    phase_raw,
    COUNT(DISTINCT nct_id) AS gene_alteration_trials
FROM clinical_trials
WHERE gene_alteration_matches IS NOT NULL
  AND gene_alteration_matches <> '[]'
GROUP BY phase_raw
ORDER BY gene_alteration_trials DESC;


-- ============================================================
-- 16. BIOMARKER TIMELINE
-- ============================================================

SELECT
    YEAR(start_date) AS start_year,

    COUNT(DISTINCT CASE
        WHEN detected_biomarkers LIKE '%EGFR%'
        THEN nct_id
    END) AS egfr_trials,

    COUNT(DISTINCT CASE
        WHEN detected_biomarkers LIKE '%ALK%'
        THEN nct_id
    END) AS alk_trials,

    COUNT(DISTINCT CASE
        WHEN detected_biomarkers LIKE '%HER2%'
        THEN nct_id
    END) AS her2_trials

FROM clinical_trials
WHERE start_date IS NOT NULL
GROUP BY YEAR(start_date)
ORDER BY start_year;


-- ============================================================
-- 17. BIOMARKER × STATUS PERCENTAGE
-- ============================================================

-- EGFR

SELECT
    'EGFR' AS biomarker,
    overall_status,
    COUNT(DISTINCT nct_id) AS trial_count,

    ROUND(
        COUNT(DISTINCT nct_id) * 100.0 /
        (
            SELECT COUNT(DISTINCT nct_id)
            FROM clinical_trials
            WHERE detected_biomarkers LIKE '%EGFR%'
        ),
        2
    ) AS percentage

FROM clinical_trials
WHERE detected_biomarkers LIKE '%EGFR%'
GROUP BY overall_status


UNION ALL


-- ALK

SELECT
    'ALK',
    overall_status,
    COUNT(DISTINCT nct_id),

    ROUND(
        COUNT(DISTINCT nct_id) * 100.0 /
        (
            SELECT COUNT(DISTINCT nct_id)
            FROM clinical_trials
            WHERE detected_biomarkers LIKE '%ALK%'
        ),
        2
    )

FROM clinical_trials
WHERE detected_biomarkers LIKE '%ALK%'
GROUP BY overall_status


UNION ALL


-- HER2

SELECT
    'HER2',
    overall_status,
    COUNT(DISTINCT nct_id),

    ROUND(
        COUNT(DISTINCT nct_id) * 100.0 /
        (
            SELECT COUNT(DISTINCT nct_id)
            FROM clinical_trials
            WHERE detected_biomarkers LIKE '%HER2%'
        ),
        2
    )

FROM clinical_trials
WHERE detected_biomarkers LIKE '%HER2%'
GROUP BY overall_status

ORDER BY biomarker, percentage DESC;


-- ============================================================
-- END OF SQL ANALYSIS
-- ============================================================
