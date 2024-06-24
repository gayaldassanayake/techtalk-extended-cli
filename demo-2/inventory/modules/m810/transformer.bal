
type InternalType EDI_810_X12_005020_810;

public isolated function transformFromEdiString(string ediText) returns anydata|error {
    EDI_810_X12_005020_810 data = check fromEdiString(ediText);
    return transformRead(data);
}

isolated function transformRead(EDI_810_X12_005020_810 data) returns InternalType => data;

public isolated function transformToEdiString(anydata content) returns string|error {
    EDI_810_X12_005020_810 data = transformWrite(check content.ensureType());
    return toEdiString(data);
}

isolated function transformWrite(InternalType data) returns EDI_810_X12_005020_810 => data;
    