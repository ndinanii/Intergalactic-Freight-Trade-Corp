// Test script to verify the Shipment, Cargo, and Customs Document data model
// This script creates sample data to test all relationships

// Step 1: Create test Account
Account testAccount = new Account(
    Name = 'Intergalactic Trading Co.',
    Type = 'Customer',
    Industry = 'Transportation'
);
insert testAccount;
System.debug('Created Account: ' + testAccount.Id);

// Step 2: Create test Contact
Contact testContact = new Contact(
    FirstName = 'John',
    LastName = 'Spacecraft',
    Email = 'john.spacecraft@example.com',
    Phone = '+1-555-0123',
    AccountId = testAccount.Id
);
insert testContact;
System.debug('Created Contact: ' + testContact.Id);

// Step 3: Create test Opportunity
Opportunity testOpportunity = new Opportunity(
    Name = 'Q4 2025 Shipment Deal',
    StageName = 'Prospecting',
    Amount = 50000,
    CloseDate = Date.today().addDays(90),
    AccountId = testAccount.Id
);
insert testOpportunity;
System.debug('Created Opportunity: ' + testOpportunity.Id);

// Step 4: Get current user
User currentUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
System.debug('Current User: ' + currentUser.Id);

// Step 5: Create a Shipment record
Shipment__c testShipment = new Shipment__c(
    Name = 'TEST-SHIP-001',
    AccountId__c = testAccount.Id,
    ContactId__c = testContact.Id,
    OpportunityId__c = testOpportunity.Id,
    ETA__c = System.now().addDays(30),
    Departure_Date__c = System.now(),
    Discount__c = 10.5,
    Assigned_Agent__c = currentUser.Id
);
insert testShipment;
System.debug('Created Shipment: ' + testShipment.Id);

// Step 6: Create Cargo records (Master-Detail relationship)
List<Cargo__c> cargoList = new List<Cargo__c>();
cargoList.add(new Cargo__c(
    Name = 'CARGO-001',
    Shipment__c = testShipment.Id,
    Category__c = 'Electronics',
    Weight__c = 150.75,
    Shipping_Method__c = 'Air Freight'
));
cargoList.add(new Cargo__c(
    Name = 'CARGO-002',
    Shipment__c = testShipment.Id,
    Category__c = 'Machinery',
    Weight__c = 500.50,
    Shipping_Method__c = 'Sea Freight'
));
insert cargoList;
System.debug('Created ' + cargoList.size() + ' Cargo records');

// Step 7: Create Customs Document records (Master-Detail relationships)
List<Customs_Document__c> customsDocList = new List<Customs_Document__c>();
customsDocList.add(new Customs_Document__c(
    Name = 'CUSTOMS-DOC-001',
    Shipment__c = testShipment.Id,
    Cargo__c = cargoList[0].Id
));
customsDocList.add(new Customs_Document__c(
    Name = 'CUSTOMS-DOC-002',
    Shipment__c = testShipment.Id,
    Cargo__c = cargoList[1].Id
));
insert customsDocList;
System.debug('Created ' + customsDocList.size() + ' Customs Document records');

// Step 8: Query to verify relationships
Shipment__c verifyShipment = [
    SELECT Id, Name, AccountId__c, ContactId__c, OpportunityId__c,
           ETA__c, Departure_Date__c, Discount__c, Assigned_Agent__c,
           (SELECT Id, Name, Category__c, Weight__c, Shipping_Method__c FROM Cargo__r),
           (SELECT Id, Name FROM Customs_Documents__r)
    FROM Shipment__c
    WHERE Id = :testShipment.Id
];

System.debug('===== VERIFICATION RESULTS =====');
System.debug('Shipment: ' + verifyShipment.Name);
System.debug('  - Account: ' + verifyShipment.AccountId__c);
System.debug('  - Contact: ' + verifyShipment.ContactId__c);
System.debug('  - Opportunity: ' + verifyShipment.OpportunityId__c);
System.debug('  - ETA: ' + verifyShipment.ETA__c);
System.debug('  - Departure Date: ' + verifyShipment.Departure_Date__c);
System.debug('  - Discount: ' + verifyShipment.Discount__c + '%');
System.debug('  - Assigned Agent: ' + verifyShipment.Assigned_Agent__c);
System.debug('  - Related Cargo: ' + verifyShipment.Cargo__r.size());
System.debug('  - Related Customs Documents: ' + verifyShipment.Customs_Documents__r.size());

for (Cargo__c cargo : verifyShipment.Cargo__r) {
    System.debug('    Cargo: ' + cargo.Name + ' | Category: ' + cargo.Category__c + 
                 ' | Weight: ' + cargo.Weight__c + 'kg | Method: ' + cargo.Shipping_Method__c);
}

for (Customs_Document__c doc : verifyShipment.Customs_Documents__r) {
    System.debug('    Customs Doc: ' + doc.Name);
}

System.debug('===== TEST COMPLETED SUCCESSFULLY =====');
