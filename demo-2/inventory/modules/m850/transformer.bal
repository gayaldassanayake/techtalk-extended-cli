
type InternalType EDI_850_X12_005020_850;

public isolated function transformFromEdiString(string ediText) returns anydata|error {
    EDI_850_X12_005020_850 data = check fromEdiString(ediText);
    return transformRead(data);
}

isolated function transformRead(EDI_850_X12_005020_850 data) returns InternalType => data;

public isolated function transformToEdiString(anydata content) returns string|error {
    EDI_850_X12_005020_850 data = transformWrite(check content.ensureType());
    return toEdiString(data);
}

isolated function transformWrite(InternalType data) returns EDI_850_X12_005020_850 => data;
    