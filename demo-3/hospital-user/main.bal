import ballerina/io;

import gayaldassanayake/hospital_client;
import ballerina/time;

public function main() {
    // scenario:
    // New patient comes, and the hospital user registers the patient
    // He is diagnosed with a skin disease, a new medical record is entered.
    hospital_client:Client|error hospitalClient = new();
    if hospitalClient is error {
        io:println("Error occurred while creating the client");
        return;
    }
    hospital_client:PatientEntry patientEntry = {firstName: "Max", lastName: "Fenton", dob: {year: 1997, month: 9, day: 19}, gender: "male"};
    hospital_client:Patient|error patient = hospitalClient->/patients.post(patientEntry);
    if patient is error {
        io:println("Error occurred while registering the patient");
        return;
    }
    io:println(string `Patient registered successfully with the id: ${patient.id}.`);
    hospital_client:MedicalRecordEntry medicalRecordEntry = {patientId: patient.id, date: time:utcToCivil(time:utcNow()) , description: "itchy skin"};
    hospital_client:MedicalRecord|error medicalRecord = hospitalClient->/records.post(medicalRecordEntry);
    if medicalRecord is error {
        io:println("Error occurred while entering the medical record");
        return;
    }
    io:println(string `Medical record for ${patient.firstName} ${patient.lastName} registered successfully with id ${medicalRecord.id}.`);
}
