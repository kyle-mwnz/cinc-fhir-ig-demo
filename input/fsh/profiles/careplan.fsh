Profile: ManaakiNgaTahiCarePlan
Parent: CarePlan
Description: "CarePlan FHIR resource for Manaaki Nga Tahi"
* ^version = "0.1.3"
// updates for v0.1.3
* careTeam 0..1     // v0.1.3 no longer prohibited
* category 0..*     // v0.1.3 now encouraged but not required yet 
* status 1..1       // v0.1.3 introduced requirement
* encounter only Reference(Encounter)     // v0.1.3 make sure the reference is to correct type
// elements modified from base profile
* activity 0..*
* activity.detail.instantiatesCanonical only Canonical(Questionnaire)
* activity.detail.scheduled[x] only Timing
* author only Reference(Practitioner)
* category from http://hl7.org/fhir/ValueSet/care-plan-category (required)      // v0.1.3
* contained only Goal
* instantiatesCanonical only Canonical(PlanDefinition)
* period 0..1
* period obeys fhir-hnz-period-utc-1
* subject only Reference(Patient)
// elements prohibited
* activity.detail.code 0..0
* activity.detail.dailyAmount 0..0
* activity.detail.description 0..0
* activity.detail.doNotPerform 0..0
* activity.detail.goal 0..0
* activity.detail.id 0..0
* activity.detail.instantiatesUri 0..0
* activity.detail.kind 0..0
* activity.detail.location 0..0
* activity.detail.modifierExtension 0..0
* activity.detail.performer 0..0
* activity.detail.product[x] 0..0
* activity.detail.quantity 0..0
* activity.detail.reasonCode 0..0
* activity.detail.reasonReference 0..0
* activity.detail.statusReason 0..0
* activity.extension 0..0
* activity.id 0..0
* activity.modifierExtension 0..0
* activity.outcomeCodeableConcept 0..0
* activity.progress 0..0
* activity.reference 0..0
* basedOn 0..0
* category 0..0
* contributor 0..0
* extension 0..0
* identifier 0..0
* implicitRules 0..0
* instantiatesUri 0..0
* language 0..0
* modifierExtension 0..0
* partOf 0..0
* replaces 0..0
* supportingInfo 0..0