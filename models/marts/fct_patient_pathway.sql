WITH stays AS (
    SELECT * FROM {{ref('stg_stays')}}
),
patients AS (
    SELECT * FROM {{source('healthcare_raw','patients')}}
)

SELECT
    s.stay_id,
    p.patient_id,
    p.age,
    p.gender,
    p.dept_code,
    s.admission_date,
    s.discharge_date,
    s.cost_euro,
    s.icd10_code,
    -- Business Logic: Is this a readmission ?
    DATE_DIFF(
        s.admission_date,
        LAG(s.discharge_date) OVER(PARTITION BY p.patient_id ORDER BY s.admission_date),
        DAY
    ) AS days_since_prev_discharge
FROM stays AS s
JOIN patients AS p
    ON s.patient_id = p.patient_id