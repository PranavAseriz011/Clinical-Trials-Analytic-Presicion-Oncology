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


```
## 📊 Dataset

The project uses a large clinical-trial dataset focused on precision oncology research.

The dataset contains information related to:

- Clinical Trial ID
- Trial Title
- Matched Condition
- Overall Status
- Study Type
- Clinical Phase
- Enrollment
- Lead Sponsor
- Sponsor Class
- Eligibility Criteria
- Trial Locations
- Start Date
- Completion Date
- Detected Biomarkers
- Detected Genetic Alterations
- Gene–Alteration Matches

### Dataset Versions

| Dataset | Description |
|---|---|
| `trials_master_UNCLEANED.csv` | Original collected clinical-trial dataset |
| `trials_master_CLEANED.csv` | Cleaned and processed dataset |
| `trials_master_ANNOTATED.csv` | Bioinformatics-annotated dataset containing biomarker and genetic alteration information |

### Dataset Size

The final annotated dataset contains:

- **42,829 rows**
- **24 columns**
- **41,547 unique clinical trials**

The difference between total rows and unique trials occurs because a clinical trial can have multiple matched-condition records.

### Dataset Access

Because the complete CSV files are large, they are hosted externally on Kaggle.

👉 **[Access the Complete Dataset on Kaggle](https://www.kaggle.com/datasets/tamalkrishnapawar/clinical-trials-precision-oncology-tvp)**

---

## 🧹 Data Cleaning & Preprocessing

The raw dataset was processed before performing the analytical and bioinformatics workflows.

The preprocessing included:

- Inspecting the raw dataset
- Handling missing values
- Cleaning clinical-trial fields
- Standardizing date fields
- Processing text-based clinical information
- Preparing structured fields for SQL analysis
- Creating a cleaned dataset for downstream analysis

The cleaned data was then used as the foundation for biomarker and genetic alteration annotation.

---

## 🧬 Bioinformatics Analysis

A bioinformatics text-processing pipeline was developed to extract precision-oncology information from clinical-trial records.

The current biomarker analysis focuses on:

- **EGFR**
- **ALK**
- **HER2**

The pipeline performs three main tasks:

### 1. Biomarker Detection

Identifies whether a clinical-trial record contains a relevant biomarker.

### 2. Genetic Alteration Detection

Detects alteration types such as:

- Mutation
- Fusion
- Rearrangement
- Amplification
- Overexpression
- Deletion

### 3. Gene–Alteration Matching

Connects detected genes with their associated genetic alterations.

Examples:

```text
EGFR → Mutation
ALK  → Fusion / Rearrangement
HER2 → Amplification / Overexpression
```
---

## 🐍 Python & Pandas

Python and Pandas were used for data loading, cleaning, preprocessing, and preparation of the clinical-trial dataset.

The main tasks included:

- Loading the raw clinical-trial dataset
- Inspecting dataset structure and data types
- Handling missing values
- Cleaning and transforming clinical-trial fields
- Standardizing date fields
- Processing text-based clinical information
- Creating the cleaned dataset
- Preparing data for bioinformatics annotation
- Exporting the final annotated dataset for SQL analysis

Python was also used to support the bioinformatics annotation pipeline by applying biomarker and genetic alteration detection to the clinical-trial records.

---

## 🗄️ MySQL Database

The annotated clinical-trial dataset was imported into a MySQL database for structured querying and analysis.

### Database Structure

```text
Database: ctpo
Table: clinical_trials
```
The table contains **24 columns**, including:

- Clinical-trial information
- Study status and type
- Clinical phase
- Enrollment
- Sponsor information
- Eligibility criteria
- Trial dates
- Biomarker annotations
- Genetic alteration annotations
- Gene–alteration matches

The annotated dataset was imported into MySQL using a Python-based batch insertion process.

---

## 🔍 SQL Analysis

SQL was used to perform structured analysis of the clinical-trial dataset.

The analysis covered:

- Data validation
- Trial status distribution
- Study type distribution
- Clinical phase distribution
- Biomarker analysis
- Biomarker vs. trial status
- Genetic alteration analysis
- Gene–alteration relationships
- Enrollment analysis
- Sponsor analysis
- Trial timeline analysis
- Biomarker vs. clinical phase
- Biomarker vs. study type
- Gene–alteration vs. trial status
- Gene–alteration vs. clinical phase

### SQL Analysis File

The complete SQL queries used for the analysis are available in:

```text
SQL/
└── SQL_Analysis_Final.sql
```
---

## 📊 Key SQL Findings

The SQL analysis produced several important insights from the clinical-trial dataset.

### Trial Overview

- **42,829 total records** were analyzed.
- The dataset contains **41,547 unique clinical trials**.
- **20,515 trials** were marked as `COMPLETED`.
- **5,377 trials** were `RECRUITING`.
- **32,934 trials** were interventional studies.
- **8,531 trials** were observational studies.

### Precision Oncology Biomarkers

The bioinformatics annotations identified trials associated with three major biomarkers:

| Biomarker | Unique Trials |
|---|---:|
| HER2 | 4,936 |
| EGFR | 4,916 |
| ALK | 1,943 |

Overall, **9,762 unique trials** contained at least one detected biomarker.

### Genetic Alterations

A total of **4,986 unique trials** contained detected genetic alterations.

The most frequently detected alteration patterns included:

- Mutation
- Amplification
- Mutation + Deletion
- Mutation + Fusion
- Mutation + Rearrangement
- Overexpression

### Gene–Alteration Relationships

The analysis identified **2,068 unique trials** containing gene–alteration matches.

Some prominent relationships included:

```text
EGFR → Mutation
ALK  → Fusion / Rearrangement
HER2 → Amplification / Overexpression
```
---

## 📊 Power BI Visualization

Power BI was used to transform the SQL analysis results into interactive dashboards and visual reports.

The dashboard focuses on:

- Clinical trial status distribution
- Study type and clinical phase analysis
- Biomarker distribution
- Biomarker vs. trial status
- Genetic alteration patterns
- Sponsor analysis
- Trial timeline
- Enrollment analysis
- Key precision-oncology insights

## 📊 Power BI Dashboard

The processed clinical-trial data and SQL analysis results were transformed into an interactive **Power BI dashboard suite** for exploring the precision-oncology clinical-trial landscape.

The Power BI analysis is organized into **four analytical dashboards**, each focusing on a different aspect of the dataset.

### Dashboard 1 — Executive Overview 

Provides a high-level overview of the clinical-trial landscape.

Key areas include:

* Total clinical-trial records
* Unique clinical trials
* Trial status distribution
* Study type distribution
* Clinical phase distribution
* Enrollment analysis
* Trial timeline
* Sponsor overview

This dashboard provides an executive-level summary of the dataset.

---

### Dashboard 2 — Biomarker Analysis

Focuses on the distribution and characteristics of precision-oncology biomarkers.

Key areas include:

* EGFR trial analysis
* ALK trial analysis
* HER2 trial analysis
* Biomarker distribution
* Biomarker vs. trial status
* Biomarker vs. clinical phase
* Biomarker vs. study type
* Comparative analysis of EGFR, ALK, and HER2

This dashboard helps identify how major precision-oncology biomarkers are represented across clinical trials.

---

### Dashboard 3 — Genetic Alteration Analysis

Analyzes the genetic alterations identified from clinical-trial text.

Key areas include:

* Genetic alteration distribution
* Mutation analysis
* Fusion analysis
* Rearrangement analysis
* Amplification analysis
* Deletion analysis
* Overexpression analysis
* Gene–alteration relationships
* Gene–alteration vs. trial status
* Gene–alteration vs. clinical phase

This dashboard provides a deeper view of the genetic characteristics associated with precision-oncology trials.

---

### Dashboard 4 — Development & Sponsor Landscap  

Explores the organizations and research patterns driving precision-oncology clinical trials.

Key areas include:

* Lead sponsor analysis
* Sponsor classification
* Trial activity by sponsor
* Enrollment by sponsor
* Trial status by sponsor
* Research activity across clinical phases
* Timeline-based research trends

This dashboard helps understand the organizations and research activity shaping the precision-oncology landscape.

---

### 📁 Power BI File

The complete Power BI report is available in the repository:

```text
PowerBI/
└── Precision_Oncology_Intelligence.pbix
```

The `.pbix` file contains the interactive dashboards, data model, measures, visualizations, filters, and analytical views developed for this project.

## 🛠️ Skills & Technologies

### Programming & Data Analysis

* Python
* Pandas
* NumPy
* Text Processing
* Data Cleaning & Preprocessing

### Bioinformatics

* Biomarker Detection
* Genetic Alteration Detection
* Gene–Alteration Matching
* Clinical Trial Text Analysis

### Database & SQL

* MySQL
* SQL Querying
* Data Validation
* Aggregations
* Subqueries
* Analytical Queries

### Business Intelligence

* Microsoft Power BI
* Data Modeling
* DAX
* Interactive Dashboards
* Data Visualization
* KPI Development
* Analytical Storytelling

### Tools

* Git & GitHub
* MySQL Workbench
* VS Code
* Power BI Desktop
* Jupyter Notebook

## 💡 Key Insights

The analysis provides a data-driven view of the precision-oncology clinical-trial landscape, highlighting:

* Distribution of clinical trials across EGFR, ALK, and HER2 biomarkers.
* Differences in trial status, study type, and clinical phase across biomarkers.
* Major genetic alteration patterns identified in precision-oncology trials.
* Relationships between genes and their associated genetic alterations.
* Clinical-trial enrollment patterns.
* Sponsor activity across precision-oncology research.
* Trends in clinical-trial activity over time.

These insights demonstrate how clinical-trial data can be transformed into structured information and interactive analytical dashboards for exploring precision-oncology research.

---


## 🚀 Project Status

**Completed ✅**

The project currently includes:

* ✅ Clinical-trial data collection and preprocessing
* ✅ Data cleaning
* ✅ Bioinformatics annotation
* ✅ Biomarker detection
* ✅ Genetic alteration detection
* ✅ Gene–alteration matching
* ✅ MySQL database
* ✅ SQL analytical queries
* ✅ Four Power BI dashboards
* ✅ Interactive data visualization
* ✅ Analytical insights

---

## 👨‍💻 Contributors

**Pranav Aseri** — Data Analytics, Python, Power BI, Pandas, Data cleaning 

**Tamalkrishna Pawar** — Data Collection, BioInformatics, Data Annotation, SQL. 

---

## 📌 Disclaimer

This project is intended for **educational and analytical purposes**. The analysis does not provide medical advice, clinical recommendations, or treatment guidance.

 
