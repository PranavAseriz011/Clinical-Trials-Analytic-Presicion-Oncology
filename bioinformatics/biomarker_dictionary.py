"""
Biomarker Knowledge Base
Project: Clinical Trials Analytic Precision Oncology

Author: Tamalkrishna Pawar
Description:
Stores biological information about clinically important biomarkers
used in precision oncology.
"""

BIOMARKERS = {

    "EGFR": {
        "full_name": "Epidermal Growth Factor Receptor",
        "associated_cancers": ["NSCLC"],
        "pathway": "EGFR Signaling",
        "approved_therapy": [
            "Osimertinib",
            "Gefitinib",
            "Erlotinib"
        ]
    },

    "ALK": {
        "full_name": "Anaplastic Lymphoma Kinase",
        "associated_cancers": ["NSCLC"],
        "pathway": "ALK Signaling",
        "approved_therapy": [
            "Crizotinib",
            "Alectinib",
            "Ceritinib"
        ]
    },

    "HER2": {
        "full_name": "Human Epidermal Growth Factor Receptor 2",
        "associated_cancers": ["Breast Cancer"],
        "pathway": "HER2 Signaling",
        "approved_therapy": [
            "Trastuzumab",
            "Pertuzumab",
            "T-DM1"
        ]
    }

}