# EDI Tool Usage

invoice
bal edi convertX12Schema -i x12-schemas/810.xsd -o ballerina-schemas/810.json

purchase order
bal edi convertX12Schema -i x12-schemas/850.xsd -o ballerina-schemas/850.json

bal edi libgen -p foodmart/inventory -i ballerina-schemas/ -o .