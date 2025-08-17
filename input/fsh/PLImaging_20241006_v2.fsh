Alias: $sct = http://snomed.info/sct
Alias: $radiology-playbook = http://fhir.loinc.org/ValueSet/loinc-rsna-radiology-playbook
Alias: $mri-fieldStrength = http://hl7.org.pl/fhir/CodeSystem/pl-imaging-mriScannerFieldStrength-cs
Alias: $icd-9-pl = urn:oid:2.16.840.1.113883.3.4424.11.2.6
Alias: $icd-10 = urn:oid:2.16.840.1.113883.6.3
Alias: $npwz-pharm = urn:oid:2.16.840.1.113883.3.4424.1.6.1
Alias: $npwz-doc = urn:oid:2.16.840.1.113883.3.4424.1.6.2
Alias: $npwz-nurse = urn:oid:2.16.840.1.113883.3.4424.1.6.3
Alias: $npwz-lab = urn:oid:2.16.840.1.113883.3.4424.1.6.4
Alias: $ids-pwdl = urn:oid:2.16.840.1.113883.3.4424.2.3.1
Alias: $ids-orgUnit = urn:oid:2.16.840.1.113883.3.4424.2.3.2
Alias: $ids-orgCell = urn:oid:2.16.840.1.113883.3.4424.2.3.3

CodeSystem: PLImagingMRIScannerFieldStrengthCS
Id: pl-imaging-mriScannerFieldStrength-cs
Title: "Słownik wartości natężenia pola magnetycznego"
Description: "Słownik wartości natężenia pola magnetycznego dla skanera MRI"
* ^version = "0.0.1"
* #05 "0,5T"
* #15 "1,5T"
* #30 "3T"
* #70 "7T"

ValueSet: PLImagingRadiologyPlaybookConceptVS
Id: pl-imaging-radiology-playbook-concept-vs
Title: "Zbiór wartości kodów Radiology Playbook"
Description: "Zbiór wartości kodów ze słownika LOINC/RSNA Radiology Playbook, które są/mogą być używane w Polsce"
* ^version = "0.0.1"
* include codes from system $radiology-playbook // To be limited in the future

ValueSet: PLImagingMRIScannerFieldStrengthVS
Id: pl-imaging-mriScannerFieldStrength-vs
Title: "Zbiór wartości natężenia pola magnetycznego"
Description: "Zbiór wartości natężenia pola magnetycznego dla skanera MRI"
* ^version = "0.0.1"
* include codes from system $mri-fieldStrength  

Profile: PLImagingProcedure
Parent: ActivityDefinition
Id: pl-imaging-procedure
Title: "Procedura badania obrazowego"
Description: "Procedura badania obrazowego z uwzględnieniem kodowania za pomocą LOINC/RSNA Radiology Playbook"
* ^version = "0.0.1"
* title 1..
* code 1..
  * coding ^slicing.discriminator.type = #pattern
  * coding ^slicing.discriminator.path = "system"
  * coding ^slicing.rules = #open
  * coding ^slicing.description = "Kodowanie procedury różnymi słownikami"
  * coding ^slicing.ordered = false
  * coding contains
    radiologyPlaybookCode 1..1 and
    icd9PlCode 0..* and
    otherCode 0..*
  * coding[radiologyPlaybookCode].system = $radiology-playbook
  * coding[icd9PlCode].system = $icd-9-pl
    
Profile: PLImagingServiceOrder
Parent: ServiceRequest
Id: pl-imaging-serviceorder
Title: "Zlecenie badania obrazowego"
Description: "Zlecenie na badanie obrazowe (Dotyczy pojedynczej procedury badania obrazowego, grupowanie zleceń za pomocą atrybutu requisition)"
* ^version = "0.0.1"
* extension contains
    OrderAdditionalPriority named contractualPriority 0..* and
    ExpectedResultDate named expectedResultDate 0..1
* identifier 1.. MS
* intent ^code.code = #order
* category = $sct#363679005
* priority 1..
* code 1..
* code only CodeableReference(PLImagingProcedure)
* orderDetail 0..*
* orderDetail ^slicing.discriminator.type = #pattern
* orderDetail ^slicing.discriminator.path = "parameter.code.coding.system"
* orderDetail ^slicing.rules = #open
* orderDetail ^slicing.description = "Natężenie pola magnetycznego jako jeden z parametrów badania"
* orderDetail ^slicing.ordered = false
* orderDetail contains
  mriFieldStrength 0..1 and
  other 0..1
* orderDetail[mriFieldStrength].parameter.code.coding.system = $mri-fieldStrength
* orderDetail[mriFieldStrength].parameter.code.coding.code from PLImagingMRIScannerFieldStrengthVS
* subject only Reference(PLBasePatient)
* encounter only Reference(PLBaseEncounter)
* authoredOn 1..
* requester 1..
* requester only Reference(PLBaseServiceRequester)
* performer ..1
* performer only Reference(PLImagingServiceCatalogue)
* location 1..1
* location only CodeableReference(PLBaseMedicalFacility or PLBaseMedicalFacilityType)
* reason 1..
* reason only CodeableReference(PLBaseDiagnosis)
* insurance only Reference(PLBaseCoverage)
* supportingInfo 1..*
* supportingInfo only CodeableReference(PLBaseProcedureReason or PLBaseDiagnosis)

Profile: PLImagingMRIScannerFieldStrength
Parent: DeviceDefinition
Id: pl-imaging-mriScannerFieldStrength
Title: "Natężenie pola magnetycznego (MRI)"
Description: "Umożliwia podanie (w zleceniu badania MRI) natężenia pola magnetycznego jako parametru"
* ^version = "0.0.1"
* classification 1..1
  * type 1..1
    * text 1..1
    * text = "Skaner MRI"
* property 1..1
  * type 1..1
  * type from PLImagingMRIScannerFieldStrengthVS

Profile: PLBasePatient
Parent: Patient
Id: pl-base-patient
Title: "Pacjent"
Description: "Bazowy profil pacjenta"
* ^version = "0.0.1"
* identifier 1..

Profile: PLBaseEncounter
Parent: Encounter
Id: pl-base-encounter
Title: "Wizyta/Pobyt"
Description: "Bazowy profil wizyty lub pobytu"
* ^version = "0.0.1"
* actualPeriod 1..

Profile: PLBaseServiceRequester
Parent: PractitionerRole
Id: pl-base-serviceRequester
Title: "Zlecający usługę medyczną"
Description: "TBC"
* ^version = "0.0.1"
* practitioner 1..
* practitioner only Reference(PLBasePractitioner)
* location 1..
* location only Reference(PLBaseMedicalFacility)

Profile: PLBaseMedicalFacility
Parent: Location
Id: pl-base-medical-facility
Title: "Placówka medyczna/Miejsce udzielania świadczeń"
Description: "Placówka medyczna/Miejsce udzielania świadczeń należace do określonego podmiotu medycznego"
* ^version = "0.0.1"
* identifier 1..*
* identifier ^slicing.discriminator.type = #pattern
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier ^slicing.description = "Różne rodzaje miejsc udzielania świadczeń"
* identifier ^slicing.ordered = false
* identifier contains
  orgUnit 0..1 and
  orgCell 0..1 and
  other 0..1
* identifier[orgUnit].system = $ids-orgUnit
* identifier[orgCell].system = $ids-orgCell
* type ^patternCodeableConcept.coding.system = "urn:oid:2.16.840.1.113883.3.4424.11.2.4"
* contact 1..
* managingOrganization 1..
* managingOrganization only Reference(PLBaseMedicalProvider)

Profile: PLBaseMedicalFacilityType
Parent: Location
Id: pl-base-medical-facility-type
Title: "Specjalność komórki organizacyjnej"
Description: "Rodzaj placówki medycznej wyrażony jako specjalność komórki organizacyjnej (wg cz.VIII kodu resortowego)"
* ^version = "0.0.1"
* identifier ..0
* type 1..1
* type ^patternCodeableConcept.coding.system = "urn:oid:2.16.840.1.113883.3.4424.11.2.4"
* contact ..0
* managingOrganization ..0

Profile: PLBaseMedicalProvider
Parent: Organization
Id: pl-base-medical-provider
Title: "Podmiot medyczny/Świadczeniodawca"
Description: "Bazowy profil podmiotu medycznego"
* ^version = "0.0.1"
* identifier 1..*
* identifier ^slicing.discriminator.type = #pattern
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier ^slicing.description = "Identyfikatory podmiotu medycznego"
* identifier ^slicing.ordered = false
* identifier contains
  pwdl 1..1 and
  other 0..1
* identifier[pwdl].system = $ids-pwdl
* name 1..1
* contact 1..

Profile: PLBasePractitioner
Parent: Practitioner
Id: pl-base-practitioner
Title: "Pracownik medyczny"
Description: "Bazowy profil pracownika medycznego"
* ^version = "0.0.1"
* identifier 1..*
* identifier ^slicing.discriminator.type = #pattern
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier ^slicing.description = "NPWZ różnych zawodów medycznych"
* identifier ^slicing.ordered = false
* identifier contains
  pharm 0..1 and
  doc 0..1 and
  nurse 0..1 and
  lab 0..1 and
  other 0..*
* identifier[pharm].system = $npwz-pharm
* identifier[doc].system = $npwz-doc
* identifier[nurse].system = $npwz-nurse
* identifier[lab].system = $npwz-lab
* name 1..

Profile: PLImagingServiceCatalogue
Parent: HealthcareService
Id: pl-imaging-service-catalogue
Title: "Katalog usług dla badań obrazowych"
Description: "Katalog usług z zakresu diagnostyki obrazowej wykonywanych (oferowanych) przez podmiot medyczny"
* ^version = "0.0.1"
* extension contains AvailableImagingProcedure named AvailableImagingProcedure 0..*
* providedBy 1..
* providedBy only Reference(PLBaseMedicalProvider)
* location only Reference(PLBaseMedicalFacility)

Profile: PLBaseAttachedDocumentReference
Parent: DocumentReference
Id: pl-base-attached-document-reference
Title: "Referencja do załącznika będącego dokumentem medycznym"
Description: "Profil bazowy referancji do dokumentu medycznego"
* ^version = "0.0.1"
* content
  * attachment
    * title 1..1
    * creation 1..1

Profile: PLImagingStudyNoteReference
Parent: DocumentReference
Id: pl-imaging-study-note-reference
Title: "Referencja do dokumentu opisu badania obrazowego"
Description: "Referencja do dokumentu opisu badania obrazowego zgodnego z PIK HL7 CDA"
* ^version = "0.0.1"
* content
  * attachment
    * contentType 1..1
    * contentType = #text/x-hl7-text+xml
    * title 1..1
    * creation 1..1
  * profile 1..1
    * value[x] only uri
    * value[x] = #urn:oid:2.16.840.1.113883.3.4424.13.10.1.1001

Profile: PLBaseCoverage
Parent: Coverage
Id: pl-base-coverage
Title: "Produkt medyczny/Model rozliczeń"
Description: "Profil bazowy dla produktu medycznego/modelu rozliczeń/ubezpieczenia"
* ^version = "0.0.1"
* identifier 1..
* beneficiary only Reference(PLBasePatient)
* insurer only Reference(PLBasePayer)
* contract only Reference(PLBaseContract)

Profile: PLBaseContract
Parent: Contract
Id: pl-base-contract
Title: "Umowa"
Description: "Profil bazowy umowy"
* ^version = "0.0.1"
* identifier 1..

Profile: PLBasePayer
Parent: Organization
Id: pl-base-payer
Title: "Płatnik"
Description: "Profil bazowy płatnika"
* ^version = "0.0.1"
* name 1..

Profile: PLBaseDiagnosis
Parent: Condition
Id: pl-base-diagnosis
Title: "Rozpoznanie"
Description: "Profil bazowy rozpoznania"
* ^version = "0.0.1"
* code 1..1
  * coding ^slicing.discriminator.type = #pattern
  * coding ^slicing.discriminator.path = "system"
  * coding ^slicing.rules = #open
  * coding ^slicing.description = ""
  * coding ^slicing.ordered = false
  * coding contains
    icd10 1..* and
    other 0..*
  * coding[icd10].system = $icd-10
* subject only Reference(PLBasePatient)

Profile: PLBaseProcedureReason
Parent: ClinicalImpression
Id: pl-base-procedureReason
Title: "Powód badania"
Description: "Opisowy cel/powód badania"
* ^version = "0.0.1"
* status = #completed
* summary 1..

Profile: PLImagingResult
Parent: ImagingStudy
Id: pl-imaging-result
Title: "Wynik badania obrazowego"
Description: "Wynik badania obrazowego"
* ^version = "0.0.1"
* identifier 1..
* status = #available
* subject 1..1
* subject only Reference(PLBasePatient)
* encounter only Reference(PLImagingEncounter)
* basedOn 1..
* basedOn only Reference(PLImagingServiceOrder)
* procedure 1..
* procedure only CodeableReference(PLImagingProcedure)

Profile: PLImagingDiagnosticReport
Parent: DiagnosticReport
Id: pl-imaging-DiagnosticReport
Title: "Opis badania obrazowego"
Description: "Opis badania obrazowego"
* ^version = "0.0.1"
* identifier 1..*
* basedOn 1..*
* basedOn only Reference(PLImagingServiceOrder)
* issued 1..1
* resultsInterpreter 1..*
* resultsInterpreter only Reference(PLBasePractitioner)
* study only Reference(PLImagingResult)
* conclusion 1..1

Profile: PLImagingEncounter
Parent: Encounter
Id: pl-imaging-encounter
Title: "Wizyta pacjenta w pracowni badania obrazowego"
Description: "Wizyta pacjenta w pracowni badania obrazowego"
* ^version = "0.0.1"
* location 1..
  * location only Reference(PLBaseMedicalFacility)

Extension: OrderAdditionalPriority
Id: order-additionalPriority
Title: "Dodatkowy priorytet zlecenia"
Description: "Dodatkowy priorytet zlecenia"
Context: ServiceRequest
* ^version = "0.0.1"
* . ^short = "Order Additional Priority"
* . ^definition = "TBC"
* value[x] only code

Extension: ExpectedResultDate
Id: serviceorder-expectedResultDate
Title: "Oczekiwana data wyniku"
Description: "Oczekiwana data wyniku podawana w zleceniu"
Context: ServiceRequest
* ^version = "0.0.1"
* . ..1
* . ^short = "Expected Result Date"
* . ^definition = "TBC"
* value[x] only date

Extension: AvailableImagingProcedure
Id: healthcareservice-imagingProcedure
Title: "Wykonywana (oferowana) procedura badania obrazowego"
Description: "Pozycja listy stanowiącej katalog usług danego podmiotu medycznego w zakresie badań obrazowych"
Context: HealthcareService
* ^version = "0.0.1"
* . ^short = "Available Imaging Procedure"
* . ^definition = "TBC"
* value[x] only Reference(PLImagingProcedure)