import ballerina/io;

import foodmart/inventory.m850;

public function main() returns error? {
    string orderText = check io:fileReadString("./resources/po_11_06_2024.edi");
    m850:EDI_850_X12_005020_850 purchaseOrder = check m850:fromEdiString(orderText);
    json purchaseOrderJson = purchaseOrder.toJson();
    io:println(purchaseOrderJson);
}