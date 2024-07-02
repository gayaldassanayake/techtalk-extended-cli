import ballerina/http;
import ballerina/uuid;

service /hospital\-support on hospitalEP {
    resource function get employees() returns Employee[] {
        return employeeTable.toArray();
    }

    resource function get employees/[string employeeId]() returns Employee|http:NotFound {
        if !employeeTable.hasKey(employeeId) {
            return {body: "Employee not found"};
        }
        return employeeTable.get(employeeId);
    }

    resource function post employees(@http:Payload EmployeeEntry employeeEntry) returns Employee {
        Employee employee = {id: uuid:createRandomUuid(), ...employeeEntry};
        employeeTable.put(employee);
        return employee;
    }

    resource function put employees/[string employeeId](@http:Payload EmployeeEntry employeeEntry) returns Employee|http:NotFound {
        if !employeeTable.hasKey(employeeId) {
            return {body: "Employee not found"};
        }
        Employee employee = {id: employeeId, ...employeeEntry};
        employeeTable.put(employee);
        return employee;
    }

    resource function delete employees/[string employeeId]() returns Employee|http:NotFound {
        if !employeeTable.hasKey(employeeId) {
            return {body: "Employee not found"};
        }
        return employeeTable.remove(employeeId);
    }

    resource function get inventory\-items() returns InventoryItem[] {
        return inventoryItemTable.toArray();
    }

    resource function get inventory\-items/[string itemId]() returns InventoryItem|http:NotFound {
        if !inventoryItemTable.hasKey(itemId) {
            return {body: "Inventory item not found"};
        }
        return inventoryItemTable.get(itemId);
    }

    resource function post inventory\-items(@http:Payload InventoryItemEntry inventoryItemEntry) returns InventoryItem {
        InventoryItem inventoryItem = {id: uuid:createRandomUuid(), ...inventoryItemEntry};
        inventoryItemTable.put(inventoryItem);
        return inventoryItem;
    }

    resource function put inventory\-items/[string itemId](@http:Payload InventoryItemEntry inventoryItemEntry) returns InventoryItem|http:NotFound {
        if !inventoryItemTable.hasKey(itemId) {
            return {body: "Inventory item not found"};
        }
        InventoryItem inventoryItem = {id: itemId, ...inventoryItemEntry};
        inventoryItemTable.put(inventoryItem);
        return inventoryItem;
    }

    resource function delete inventory\-items/[string itemId]() returns InventoryItem|http:NotFound {
        if !inventoryItemTable.hasKey(itemId) {
            return {body: "Inventory item not found"};
        }
        return inventoryItemTable.remove(itemId);
    }
}
