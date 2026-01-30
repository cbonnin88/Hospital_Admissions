SELECT
  p.dept_code,
  h.category,
  COUNT(s.stay_id) AS total_stays,
  ROUND(SUM(s.stay_cost),2) AS total_revenue,
  -- Calculating % of revenue within that specific department
  ROUND(100 * SUM(s.stay_cost) / SUM(SUM(s.stay_cost)) OVER(PARTITION BY p.dept_code),2) AS pct_dept_revenue
FROM `healthcare_data.hospital_stays` AS s
JOIN `healthcare_data.hospitals` AS h
  ON s.hospital_id = h.hospital_id
JOIN `healthcare_data.patients` AS p
  ON s.patient_id = p.patient_id
GROUP BY
  1,2
ORDER BY
  1,
  total_revenue DESC;