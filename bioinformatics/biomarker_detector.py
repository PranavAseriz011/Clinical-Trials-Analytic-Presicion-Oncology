"""
Biomarker Detection Engine

Author: Tamal Pawar

Purpose:
Detect clinically relevant biomarkers from clinical trial
eligibility criteria.
"""

import re

from .biomarker_dictionary import BIOMARKERS


def detect_biomarkers(text):
    """
    Detect biomarkers mentioned in eligibility criteria.

    Parameters
    ----------
    text : str
        Eligibility criteria text.

    Returns
    -------
    list
        List of detected biomarker names.
    """

    detected = []

    if not isinstance(text, str):
        return detected

    for gene in BIOMARKERS.keys():

        pattern = rf"\b{gene}\b"

        if re.search(pattern, text, re.IGNORECASE):

          detected.append({
               "gene": gene,
                 **BIOMARKERS[gene]
                })

    return detected

def detect_alterations(text):
    """
    Detect common genetic alteration terms in clinical trial text.
    """

    alterations = []

    if not isinstance(text, str):
        return alterations

    alteration_patterns = {
        "Mutation": r"\bmutat(?:ion|ed|ions)\b",
        "Fusion": r"\bfusion(?:s)?\b",
        "Rearrangement": r"\brearrangement(?:s)?\b",
        "Amplification": r"\bamplification(?:s)?\b",
        "Overexpression": r"\boverexpression\b",
        "Deletion": r"\bdeletion(?:s)?\b"
    }

    for alteration, pattern in alteration_patterns.items():
        if re.search(pattern, text, re.IGNORECASE):
            alterations.append(alteration)

    return alterations

def match_gene_alterations(text):
    """
    Match detected biomarkers with nearby genetic alterations.
    """

    matches = []

    if not isinstance(text, str):
        return matches

    alteration_patterns = {
        "Mutation": r"mutat(?:ion|ed|ions)",
        "Fusion": r"fusion(?:s)?",
        "Rearrangement": r"rearrangement(?:s)?",
        "Amplification": r"amplification(?:s)?",
        "Overexpression": r"overexpression",
        "Deletion": r"deletion(?:s)?"
    }

    for gene in BIOMARKERS.keys():

        gene_pattern = rf"\b{gene}\b"

        for alteration, alteration_pattern in alteration_patterns.items():

            pattern = rf"{gene_pattern}\s+(?:\w+\s+){{0,3}}{alteration_pattern}\b"

            match = re.search(pattern, text, re.IGNORECASE)

            if match:
                matches.append({
                    "gene": gene,
                    "alteration": alteration,
                    "evidence": match.group(0)
                })

    return matches


if __name__ == "__main__":

    sample = """
Patients with EGFR mutation are eligible.
Patients with ALK fusion are excluded.
HER2 amplification is required.
"""

    print("Biomarkers:")
    print(detect_biomarkers(sample))

    print("\nAlterations:")
    print(detect_alterations(sample))

    print("\nGene-Alteration Matches:")
    print(match_gene_alterations(sample))