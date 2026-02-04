# 🏥 France Healthcare: End-to-End Clinical & Financial Analytics
### *Predicting 30-Day Readmissions using GCP, dbt, and Polars*

## 📌 Project Overview
This project simulates the **SNDS** (Système National des Données de Santé) framework to analyze patient care pathways across the **Île-de-France** region. By integrating disparate datasets, I built a predictive pipeline to identify high-cost patients and the likelihood of 30-day hospital readmissions, providing actionable insights for the **ARS (Agence Régionale de Santé)**.

## 🛠 Tech Stack
* **Data Engineering:** Python, Polars (High-performance ETL)
* **Cloud Data Warehouse:** Google Cloud Platform (GCS & BigQuery)
* **Analytics Engineering:** dbt Cloud (Staging/Marts Architecture)
* **Machine Learning:** Scikit-Learn (Random Forest Classifier)
* **Business Intelligence:** Looker Studio & Plotly

---

## 🏗 Data Architecture & Pipeline

### 1. High-Performance ETL (Polars)
* **Scale:** Synthesized and processed **120,000+ records** across four relational tables (Patients, Stays, Pharmacy, and Hospitals).
* **Efficiency:** Utilized **Polars** to handle data cleaning—standardizing French department codes (e.g., "75001" to "75") and handling schema inference issues 10x faster than traditional Pandas.
* **Integrity:** Implemented logic-based cleaning to ensure clinical validity (e.g., ensuring `discharge_date` >= `admission_date`).

### 2. Analytics Engineering (dbt & BigQuery)
* **Warehouse:** Hosted on **BigQuery**, utilizing partitioned tables for optimized query performance.
* **Modeling:** Developed a modular dbt pipeline:
    * **Staging:** Cast raw types and standardized medical terminology (e.g., renaming `diagnosis_code` to `icd10_code`).
    * **Marts:** Engineered a "Patient Pathway" table using **Window Functions** (`LAG`) to calculate the delta between hospital stays.
* **Data Quality:** Deployed dbt tests to enforce `unique`, `not_null`, and custom business rules.



### 3. Predictive Modeling (Scikit-Learn)
* **Objective:** Predict the probability of a patient being readmitted within 30 days.
* **Algorithm:** **Random Forest Classifier** with `class_weight='balanced'` to account for the minority class (readmitted patients).
* **Evaluation:** Optimized for **Recall** to ensure high-risk patients are not missed. Visualized performance via **Confusion Matrix** and **Classification Report Heatmaps** using Plotly.

---

## 📊 Business Insights (Looker Studio)
**Dashboard:** [*Île-de-France Regional Patient Flow Command Center*](https://lookerstudio.google.com/reporting/c5ea51b1-7959-408b-b3f9-fb81d489a43a)

* **Regional Disparities:** Analysis revealed that **Department 93** exhibited a 15% higher readmission rate than the regional average, indicating a need for post-discharge social support.
* **Clinical Burden:** Identified **COPD (J44.0)** as the primary driver of high-cost hospital stays.
* **Predictive Power:** The ML model identified `age` and `stay_cost` as the top two predictors of 30-day readmission risk.


---

## 🚀 How to Use This Repo
1.  **Notebooks:** View `cleaning_eda.ipynb` for the Polars-based ETL and `ml_model.ipynb` for the Scikit-Learn implementation.
2.  **dbt Models:** Navigate to the `/models` directory to see the SQL transformations and lineage.
3.  **SQL:** Check `/queries` for advanced BigQuery analytical scripts (Window functions, CTEs).

---

## 📈 Future Scope
* Integrate **dbt-expectations** for more rigorous clinical validation.
* Deploy the ML model as a REST API using **Google Cloud Functions**.
* Add a **Geographic Information System (GIS)** layer to map hospital proximity to patient clusters.
