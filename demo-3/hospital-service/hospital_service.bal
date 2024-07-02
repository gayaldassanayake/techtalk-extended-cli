import ballerina/http;
import ballerina/uuid;

listener http:Listener hospitalEP = new (9090);

service /hospital on hospitalEP {

    # Get a list of patients
    #
    # + return - A list of patients 
    resource function get patients() returns Patient[] {
        return patientTable.toArray();
    }

    # Get a patient by ID
    #
    # + return - returns can be any of following types 
    # http:Ok (Patient details)
    # http:NotFound (Patient not found)
    resource function get patients/[string patientId]() returns Patient|http:NotFound {
        if !patientTable.hasKey(patientId) {
            return {body: "Patient not found"};
        }
        return patientTable.get(patientId);
    }

    # Create a new patient
    #
    # + patientEntry - PatientEntry object to be created 
    # + return - Patient created successfully 
    resource function post patients(@http:Payload PatientEntry patientEntry) returns Patient {
        Patient patient = {id: uuid:createRandomUuid(), ...patientEntry};
        patientTable.put(patient);
        return patient;
    }

    # Update a patient by ID
    #
    # + patientEntry - Patient object to be updated 
    # + return - returns can be any of following types 
    # http:Ok (Patient updated successfully)
    # http:NotFound (Patient not found)
    resource function put patients/[string patientId](@http:Payload PatientEntry patientEntry) returns Patient|http:NotFound {
        if !patientTable.hasKey(patientId) {
            return {body: "Patient not found"};
        }
        Patient patient = {id: patientId, ...patientEntry};
        patientTable.put(patient);
        return patient;
    }

    # Delete a patient by ID
    #
    # + return - returns can be any of following types 
    # http:NoContent (Patient deleted successfully)
    # http:NotFound (Patient not found)
    resource function delete patients/[string patientId]() returns Patient|http:NotFound {
        if !patientTable.hasKey(patientId) {
            return {body: "Patient not found"};
        }
        return patientTable.remove(patientId);
    }

    # Get a list of medical records
    #
    # + return - A list of medical records 
    resource function get records() returns MedicalRecord[] {
        return recordTable.toArray();
    }

    # Get a medical record by ID
    #
    # + return - returns can be any of following types 
    # http:Ok (MedicalRecord details)
    # http:NotFound (MedicalRecord not found)
    resource function get records/[string recordId]() returns MedicalRecord|http:NotFound {
    if !recordTable.hasKey(recordId) {
            return {body: "Record not found"};
        }
        return recordTable.get(recordId);
    }

    # Create a new medical record
    #
    # + recordEntry - MedicalRecord object to be created 
    # + return - Medical created successfully 
    resource function post records(@http:Payload MedicalRecordEntry recordEntry) returns MedicalRecord|http:NotFound {
        if !patientTable.hasKey(recordEntry.patientId) {
            return {body: "Patient not found"};
        }
        MedicalRecord medRecord = {id: uuid:createRandomUuid(), ...recordEntry};
        recordTable.put(medRecord);
        return medRecord;
    }

    # Update a recoed by ID
    #
    # + recordEntry - Medical record object to be updated 
    # + return - returns can be any of following types 
    # http:Ok (Medical record updated successfully)
    # http:NotFound (Medical record or Patient not found)
    resource function put records/[string recordId](@http:Payload MedicalRecordEntry recordEntry) returns MedicalRecord|http:NotFound {
        if !patientTable.hasKey(recordEntry.patientId) {
            return {body: "Patient not found"};
        }
        if !recordTable.hasKey(recordId) {
            return {body: "Medical record not found"};
        }
        MedicalRecord medRecord = {id: recordId, ...recordEntry};
        recordTable.put(medRecord);
        return medRecord;
    }

    # Delete a record by ID
    #
    # + return - returns can be any of following types 
    # http:NoContent (Medical record deleted successfully)
    # http:NotFound (Medical record not found)
    resource function delete records/[string recordId]() returns MedicalRecord|http:NotFound {
        if !recordTable.hasKey(recordId) {
            return {body: "Medical record not found"};
        }
        return recordTable.remove(recordId);
    }

    # Get medical records for a Patient ID
    #
    # + return - returns can be any of following types 
    # http:Ok (MedicalRecord details)
    # http:NotFound (Patient not found)
    resource function get recordsByPatient/[string patientId]() returns MedicalRecord[]|http:NotFound {
        if !patientTable.hasKey(patientId) {
            return {body: "Patient not found"};
        }
        return recordTable.filter((medRecord) => medRecord.patientId == patientId).toArray();
    }
}
