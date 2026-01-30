WITH dept_cost AS (
  SELECT
    p.dept_code,
    s.stay_cost,
    s.diagnosis_code
  FROM `healthcare_data.hospital_stays` AS s
  JOIN `healthcare_data.patients` AS p
    ON s.patient_id = p.patient_id
)
SELECT
  dept_code,
  ROUND(AVG(stay_cost),2) as avg_cost_per_dept,
  COUNT(*) AS total_admissions
FROM dept_cost
GROUP BY 
  1
ORDER BY 
  avg_cost_per_dept DESC