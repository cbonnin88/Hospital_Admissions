WITH source AS (
    SELECT * FROM {{source('healthcare_raw','hospital_stays')}}
)

SELECT
    stay_id,
    patient_id,
    hospital_id,
    CAST(admission_date AS DATE) AS admission_date,
    CAST(discharge_date AS DATE) AS discharge_date,
    diagnosis_code AS icd10_code, -- Standardizing naming
    stay_cost AS cost_euro
FROM source