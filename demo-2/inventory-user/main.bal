import ballerina/io;
import ballerina/random;
import ballerina/time;

import aerospace/inventory.m810;
import aerospace/inventory.m850;

public function main() returns error? {
    // read the purchase order from ./resources/po_11_06_2024.edi file
    string orderText = check io:fileReadString("./resources/po_11_06_2024.edi");
    m850:EDI_850_X12_005020_850 purchaseOrder = check m850:fromEdiString(orderText);

    // transform the purchase order to an invoice
    m810:EDI_810_X12_005020_810 invoice = getInvoiceFromPurchaseOrder(purchaseOrder);
    io:println(invoice.toJson());
}

function getInvoiceFromPurchaseOrder(m850:EDI_850_X12_005020_850 purchaseOrder) returns m810:EDI_810_X12_005020_810 {
    return {
        // header
        TransactionSetHeader: {
            ST01__TransactionSetIdentifierCode: "810",
            ST02__TransactionSetControlNumber: "0001"
        },
        // beginning of the invoice 
        BeginningSegmentforInvoice: {
            BIG01__Date: time:utcNow().toString(),
            BIG02__InvoiceNumber: getInvoiceNumber()
        },
        // items
        Loop_2_0100:
            from var item in purchaseOrder.Loop_2_0100
        select {
            BaselineItemDataInvoice: {
                IT101__AssignedIdentification: item?.BaselineItemData?.PO101__AssignedIdentification,
                IT102__QuantityInvoiced: item?.BaselineItemData?.PO102__Quantity ?: "0",
                IT103__UnitorBasisforMeasurementCode: item?.BaselineItemData?.PO103__UnitorBasisforMeasurementCode ?: "EA",
                IT104__UnitPrice: item?.BaselineItemData?.PO104__UnitPrice ?: "0",
                IT105__BasisofUnitPriceCode: item?.BaselineItemData?.PO105__BasisofUnitPriceCode,
                IT106__ProductServiceIDQualifier: item?.BaselineItemData?.PO106__ProductServiceIDQualifier ?: "BP",
                IT107__ProductServiceID: item?.BaselineItemData?.PO107__ProductServiceID ?: "34098"
            }
        }
    };
}

function getInvoiceNumber() returns string {
    int|error randomInt = random:createIntInRange(1000, int:MAX_VALUE);
    if randomInt is error {
        return "0001";
    }
    return randomInt.toString();
}