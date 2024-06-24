

import inventory.m810;
import inventory.m850;

type EdiSerialize isolated function (anydata) returns string|error;
type EdiDeserialize isolated function (string) returns anydata|error;

public enum EDI_NAME {
    EDI_810 = "810", EDI_850 = "850"
}

public isolated function getEDINames() returns string[] {
    return ["810","850"];
}

public isolated function fromEdiString(string ediText, EDI_NAME ediName) returns anydata|error {
    EdiDeserialize? ediDeserialize = ediDeserializers[ediName];
    if ediDeserialize is () {
        return error("EDI deserializer is not initialized for EDI type: " + ediName);
    }
    return ediDeserialize(ediText);
}

public isolated function toEdiString(anydata data, EDI_NAME ediName) returns string|error {
    EdiSerialize? ediSerialize = ediSerializers[ediName];
    if ediSerialize is () {
        return error("EDI serializer is not initialized for EDI type: " + ediName);
    }
    return ediSerialize(data);
}

final readonly & map<EdiDeserialize> ediDeserializers = {
        "810": m810:transformFromEdiString,
    "850": m850:transformFromEdiString
};

final readonly & map<EdiSerialize> ediSerializers = {
        "810": m810:transformToEdiString,
    "850": m850:transformToEdiString
};
    