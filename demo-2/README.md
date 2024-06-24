# EDI Tool Usage

This guide provides instructions on how to use the Ballerina EDI tool to generate Ballerina code from EDI schemas.

![alt text](./inventory-user/resources/image.png)

We have two x12 schemas.
1. 810.xsd - Schema for an invoice
2. 850.xsd - Schema for a purchase order

First, we need to convert the x12 schemas into Ballerina EDI schemas. For this we can use the `convertX12Schema` command of the EDI tool.

```bash
bal edi convertX12Schema -i x12-schemas/810.xsd -o ballerina-schemas/810.json
```

```bash
bal edi convertX12Schema -i x12-schemas/850.xsd -o ballerina-schemas/850.json
```

Now that we have the Ballerina EDI schemas, we can generate a Ballerina library for manipulating any EDI messages. This is done using the `libgen` command.

```bash
bal edi libgen -p foodmart/inventory -i ballerina-schemas/ -o .
```

