# Clinical Trials Analytics — Precision Oncology

## 📌 Project Overview

Clinical Trials Analytics — Precision Oncology is an end-to-end data analytics and bioinformatics project focused on exploring clinical trial data related to precision oncology.

The project combines **Python, Bioinformatics, SQL, Pandas, and Power BI** to transform raw clinical-trial data into structured, analyzable information and identify patterns related to biomarkers, genetic alterations, clinical phases, trial status, enrollment, sponsors, and research trends.

The project demonstrates a complete analytical workflow:

**Raw Data → Data Cleaning → Bioinformatics Annotation → SQL Database → SQL Analysis → Power BI Visualization → Insights**

---

## 🎯 Project Objectives

The main objectives of this project are:

- Analyze a large clinical-trial dataset related to precision oncology.
- Clean and preprocess raw clinical-trial data.
- Identify important biomarkers from clinical-trial text.
- Detect genetic alterations associated with precision oncology.
- Match genes with their associated alterations.
- Store the processed data in a MySQL database.
- Perform exploratory and analytical SQL queries.
- Analyze clinical trial status, study type, phase, enrollment, sponsors, and timelines.
- Compare **EGFR, ALK, and HER2** across different clinical-trial characteristics.
- Prepare analytical outputs suitable for visualization in Power BI.
- Generate meaningful insights from the clinical-trial landscape.

---

# 🧬 Project Workflow

```text
                RAW CLINICAL TRIAL DATA
                          │
                          ▼
               DATA CLEANING & PROCESSING
                          │
                          ▼
                  BIOMARKER DETECTION
                          │
                 ┌────────┴────────┐
                 ▼                 ▼
       Biomarker Detection   Alteration Detection
                 │                 │
                 └────────┬────────┘
                          ▼
                   GENE–ALTERATION
                      MATCHING
                          │
                          ▼
                  ANNOTATED DATASET
                          │
                          ▼
                   MYSQL DATABASE
                          │
                          ▼
                    SQL ANALYSIS
                          │
                          ▼
                  POWER BI ANALYSIS
                          │
                          ▼
                       INSIGHTS
