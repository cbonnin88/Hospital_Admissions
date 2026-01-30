WITH patient_spend AS (
  SELECT
    patient_id,
    SUM(stay_cost) AS total_spent,
    COUNT(stay_id) AS stay_count
  FROM `france-healthcare-analytics.healthcare_data.hospital_stays`
  GROUP BY 
    1
),
ranked_patients AS (
  SELECT
    *,
    PERCENT_RANK() OVER(ORDER BY total_spent DESC) AS spend_percentile
  FROM patient_spend
)
SELECT
  patient_id,
  total_spent,
  stay_count,
  CASE
    WHEN spend_percentile <= 0.05 THEN 'High Utilize'
    ELSE 'Standard'
  END AS patient_category
FROM ranked_patients
WHERE spend_percentile <= 0.10 -- Looking at top 10%
ORDER BY
  total_spent DESC;