# CORRECTIONS.md — pl-fhir-imaging

## Corrections applied

### REA-009: Remove duplicate ValueSet entry
**File:** input/fsh/terminology/pl-imaging-loincRadiologyConcept-VS.fsh  
**Problem:** Duplicate entry in ValueSet: "RTG biodra prawego 2 lub 3 projekcje" appeared with LOINC 103234-1 (line 25) and LOINC 103238-2 (line 29) — same display, different codes.  
**Correction:** Removed duplicate entry LOINC 103238-2.  
**Evidence:** `Select-String` found 2 occurrences of "RTG biodra prawego 2 lub 3 projekcje" before correction.

### REA-010: Remove duplicate ValueSet entry
**File:** input/fsh/terminology/pl-imaging-loincRadiologyConcept-VS.fsh  
**Problem:** Duplicate entry: "RTG biodra obustronnie 3 lub 4 projekcje" appeared with LOINC 103266-3 (line 57) and LOINC 103267-1 (line 58) — same display, different codes.  
**Correction:** Removed duplicate entry LOINC 103267-1.  
**Evidence:** `Select-String` found 2 consecutive occurrences of "RTG biodra obustronnie 3 lub 4 projekcje" before correction.

### REA-011: Remove placeholder comment
**File:** input/fsh/aliases.fsh  
**Problem:** Comment `// Remove this comment` left at end of file.  
**Correction:** Removed the placeholder comment.  
**Evidence:** Line 56 of aliases.fsh had `// Remove this comment`.

### REA-012: Activate hl7.fhir.pl.base.r5 dependency
**File:** sushi-config.yaml  
**Problem:** Dependency `hl7.fhir.pl.base.r5` was commented out, but Imaging profiles reference `PLBase*` types (PLBasePatient, PLBaseEncounter, PLBaseServiceRequester, etc.) that only exist in that dependency.  
**Correction:** Uncommented the dependency.  
**Evidence:** sushi-config.yaml:29 had `# hl7.fhir.pl.base.r5: 0.1.0`.

### REA-013: Add missing README.md
**File:** README.md (new)  
**Problem:** Repository had no README.md (only pl-fhir-lab had one).  
**Correction:** Created README.md with IG description, structure and build instructions.  
**Evidence:** `Get-ChildItem` did not find README.md in the repository before correction.

## Problems not corrected
None.

## Remaining risks
- External dependency `hl7.fhir.pl.base.r5` must be available for successful build.
- Build not validated (SUSHI not installed in environment).
