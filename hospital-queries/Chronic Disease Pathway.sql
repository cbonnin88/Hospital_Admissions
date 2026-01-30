WITH pharmacy_agg AS (
  SELECT
    patient_id,
    ROUND(SUM(claim_amount),2) AS total_pharmacy_spend,
    COUNT(claim_id) AS prescription_count
  FROM `healthcare_data.pharmacy_claims`
  GROUP BY
    1
),
hospital_agg AS (
  SELECT
    patient_id,
    AVG(DATE_DIFF(discharge_date,admission_date, DAY)) AS avg_los,
    ROUND(SUM(stay_cost),2) AS total_hospital_spend
  FROM `healthcare_data.hospital_stays`
  GROUP BY
    1
)
SELECT
  h.patient_id,
  p.total_pharmacy_spend,
  p.prescription_count,
  h.avg_los,
  h.total_hospital_spend
FROM hospital_agg AS h
LEFT JOIN pharmacy_agg AS p
  ON h.patient_id = p.patient_id
WHERE p.total_pharmacy_spend IS NOT NULL
ORDER BY
  p.total_pharmacy_spend DESC
LIMIT 100;
