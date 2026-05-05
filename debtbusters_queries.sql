-- ================================================================
-- PROJECT 1: DebtBusters South Africa
-- Title:     SA Consumer Credit and Debt Review Analysis
-- Author:    Gracey F.
-- Tools:     SQLite | DB Browser for SQLite
-- Data:      National Credit Regulator (NCR) — Consumer Credit
--            Market Reports Q4 2019 to Q4 2024
-- Source:    https://www.ncr.org.za
-- ================================================================
-- HOW TO USE THIS FILE:
-- 1. Open DB Browser for SQLite
-- 2. Click Open Database and select debtbusters_ncr.db
-- 3. Click the Execute SQL tab
-- 4. Copy and paste any query below into the editor
-- 5. Click the Play button (F5) to run it
-- 6. Results appear in the panel below
-- ================================================================


-- ================================================================
-- SECTION 1: MARKET OVERVIEW
-- ================================================================

-- Q1: How has total consumer credit outstanding grown from 2019 to 2024?
-- Business relevance: Shows the growing debt environment DebtBusters operates in

SELECT
    quarter,
    year,
    total_credit_outstanding_bn                             AS credit_outstanding_R_billion,
    total_credit_active_consumers,
    ROUND(total_credit_outstanding_bn - LAG(total_credit_outstanding_bn)
          OVER (ORDER BY quarter), 1)                       AS quarterly_change_R_bn
FROM credit_market_summary
ORDER BY quarter;


-- Q2: What percentage of South African consumers hold impaired accounts?
-- Business relevance: Directly indicates the size of the market DebtBusters serves

SELECT
    quarter,
    year,
    total_credit_active_consumers,
    impaired_accounts_count,
    impaired_accounts_pct                                   AS impaired_pct,
    ROUND(impaired_accounts_count * 1.0
          / total_credit_active_consumers * 100, 1)         AS calculated_impaired_pct
FROM credit_market_summary
ORDER BY quarter;


-- Q3: How did COVID-19 affect new credit granted in 2020?
-- Business relevance: Demonstrates impact of economic shocks on credit behaviour

SELECT
    quarter,
    year,
    new_credit_granted_bn,
    ROUND(new_credit_granted_bn - LAG(new_credit_granted_bn)
          OVER (ORDER BY quarter), 1)                       AS change_from_prev_quarter,
    CASE
        WHEN year = 2020 THEN 'COVID-19 Period'
        WHEN year < 2020 THEN 'Pre-COVID'
        ELSE 'Post-COVID Recovery'
    END                                                     AS period_label
FROM credit_market_summary
ORDER BY quarter;


-- ================================================================
-- SECTION 2: DEBT REVIEW TRENDS
-- ================================================================

-- Q4: How has the volume of debt review applications grown over time?
-- Business relevance: Core metric for DebtBusters business growth tracking

SELECT
    quarter,
    year,
    new_applications,
    total_under_debt_review,
    registered_debt_counsellors,
    ROUND(new_applications * 1.0
          / registered_debt_counsellors, 1)                 AS applications_per_counsellor
FROM debt_review_applications
ORDER BY quarter;


-- Q5: What is the debt review approval vs rejection rate per quarter?
-- Business relevance: Measures efficiency and quality of debt review process

SELECT
    quarter,
    year,
    new_applications,
    applications_granted,
    applications_rejected,
    ROUND(applications_granted * 100.0 / new_applications, 1)   AS approval_rate_pct,
    ROUND(applications_rejected * 100.0 / new_applications, 1)  AS rejection_rate_pct
FROM debt_review_applications
ORDER BY quarter;


-- Q6: Year-on-year growth in new debt review applications
-- Business relevance: Shows whether demand for debt counselling is increasing

SELECT
    year,
    SUM(new_applications)                                   AS total_applications,
    SUM(total_under_debt_review) / COUNT(*)                 AS avg_under_review,
    SUM(rescissions_granted)                                AS total_rescissions,
    ROUND(SUM(new_applications) - LAG(SUM(new_applications))
          OVER (ORDER BY year), 0)                          AS yoy_change,
    ROUND((SUM(new_applications) - LAG(SUM(new_applications))
          OVER (ORDER BY year)) * 100.0
          / LAG(SUM(new_applications)) OVER (ORDER BY year), 1) AS yoy_growth_pct
FROM debt_review_applications
GROUP BY year
ORDER BY year;


-- Q7: How many consumers successfully exited debt review (rescissions)?
-- Business relevance: Measures successful debt rehabilitation outcomes

SELECT
    quarter,
    year,
    rescissions_granted                                     AS successful_exits,
    total_under_debt_review,
    ROUND(rescissions_granted * 100.0
          / total_under_debt_review, 2)                     AS exit_rate_pct
FROM debt_review_applications
ORDER BY quarter;


-- ================================================================
-- SECTION 3: IMPAIRMENT ANALYSIS
-- ================================================================

-- Q8: Which credit type has the highest impairment rate?
-- Business relevance: Identifies where over-indebtedness is most concentrated

SELECT
    credit_type,
    total_accounts,
    impaired_count,
    impaired_pct,
    RANK() OVER (ORDER BY impaired_pct DESC)                AS risk_rank
FROM impaired_by_credit_type
WHERE quarter = 'Q4 2024'
ORDER BY impaired_pct DESC;


-- Q9: How many South Africans are impaired across all credit types?
-- Business relevance: Total addressable market for debt counselling services

SELECT
    SUM(total_accounts)                                     AS total_accounts_all_types,
    SUM(impaired_count)                                     AS total_impaired,
    ROUND(SUM(impaired_count) * 100.0
          / SUM(total_accounts), 1)                         AS overall_impaired_pct,
    MAX(impaired_pct)                                       AS highest_impairment_rate,
    MIN(impaired_pct)                                       AS lowest_impairment_rate
FROM impaired_by_credit_type
WHERE quarter = 'Q4 2024';


-- ================================================================
-- SECTION 4: BUSINESS INTELLIGENCE SUMMARY
-- ================================================================

-- Q10: Combined market health snapshot — latest quarter vs two years prior
-- Business relevance: Executive summary view for strategic planning

SELECT
    c.quarter,
    c.total_credit_outstanding_bn                           AS credit_outstanding_R_bn,
    c.impaired_accounts_pct                                 AS impaired_pct,
    d.new_applications                                      AS debt_review_applications,
    d.total_under_debt_review,
    d.rescissions_granted                                   AS successful_rehabilitations,
    d.registered_debt_counsellors
FROM credit_market_summary c
JOIN debt_review_applications d ON c.quarter = d.quarter
WHERE c.quarter IN ('Q4 2022', 'Q4 2023', 'Q4 2024')
ORDER BY c.quarter;
