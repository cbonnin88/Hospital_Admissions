WITH patient_timeline AS (
  SELECT
    patient_id,
    admission_date,
    discharge_date,
    LAG(discharge_date) OVER(PARTITION BY patient_id ORDER BY admission_date) AS previous_discharge
  FROM `healthcare_data.hospital_stays`
)
SELECT
  *,
  DATE_DIFF(admission_date,previous_discharge,DAY) AS days_since_last_stay
FROM patient_timeline
WHERE DATE_DIFF(admission_date,previous_discharge, DAY) <= 30;