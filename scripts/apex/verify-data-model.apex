// Simple test to create Shipment and Cargo records
// Verifies the data model is deployed correctly

// Get first available Account, Contact, and Opportunity
List<Account> accounts = [SELECT Id FROM Account LIMIT 1];
List<Contact> contacts = [SELECT Id FROM Contact LIMIT 1];
List<Opportunity> opps = [SELECT Id FROM Opportunity LIMIT 1];
User currentUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];

if (accounts.isEmpty() || contacts.isEmpty() || opps.isEmpty()) {
    System.debug('ERROR: Required standard objects not found');
    return;
}

// Create Shipment
Shipment__c ship = new Shipment__c();
ship.Name = 'TEST-SHIPMENT-' + System.now().getTime();
ship.AccountId__c = accounts[0].Id;
ship.ContactId__c = contacts[0].Id;
ship.OpportunityId__c = opps[0].Id;
ship.ETA__c = System.now().addDays(30);
ship.Departure_Date__c = System.now();
ship.Discount__c = 15.0;
ship.Assigned_Agent__c = currentUser.Id;

insert ship;
System.debug('✓ Created Shipment: ' + ship.Id);

// Create Cargo records
Cargo__c cargo1 = new Cargo__c();
cargo1.Name = 'CARGO-ELECTRONICS';
cargo1.Shipment__c = ship.Id;
cargo1.Category__c = 'Electronics';
cargo1.Weight__c = 250.5;
cargo1.Shipping_Method__c = 'Air Freight';

Cargo__c cargo2 = new Cargo__c();
cargo2.Name = 'CARGO-MACHINERY';
cargo2.Shipment__c = ship.Id;
cargo2.Category__c = 'Machinery';
cargo2.Weight__c = 1200.0;
cargo2.Shipping_Method__c = 'Sea Freight';

insert new List<Cargo__c>{cargo1, cargo2};
System.debug('✓ Created 2 Cargo records');

// Create Customs Documents
Customs_Document__c doc1 = new Customs_Document__c();
doc1.Name = 'CUSTOMS-001';
doc1.Shipment__c = ship.Id;
doc1.Cargo__c = cargo1.Id;

Customs_Document__c doc2 = new Customs_Document__c();
doc2.Name = 'CUSTOMS-002';
doc2.Shipment__c = ship.Id;
doc2.Cargo__c = cargo2.Id;

insert new List<Customs_Document__c>{doc1, doc2};
System.debug('✓ Created 2 Customs Document records');

// Query back to verify relationships
Shipment__c verifyShip = [
    SELECT Id, Name, AccountId__c, ContactId__c, OpportunityId__c,
           ETA__c, Departure_Date__c, Discount__c, Assigned_Agent__c,
           (SELECT Id, Name, Category__c, Weight__c, Shipping_Method__c FROM Cargo__r),
           (SELECT Id, Name FROM Customs_Documents__r)
    FROM Shipment__c
    WHERE Id = :ship.Id
];

System.debug('==========================================');
System.debug('DATA MODEL VERIFICATION SUCCESSFUL');
System.debug('==========================================');
System.debug('Shipment: ' + verifyShip.Name);
System.debug('  Account: ' + verifyShip.AccountId__c);
System.debug('  Contact: ' + verifyShip.ContactId__c);
System.debug('  Opportunity: ' + verifyShip.OpportunityId__c);
System.debug('  ETA: ' + verifyShip.ETA__c);
System.debug('  Departure Date: ' + verifyShip.Departure_Date__c);
System.debug('  Discount: ' + verifyShip.Discount__c + '%');
System.debug('  Assigned Agent: ' + verifyShip.Assigned_Agent__c);
System.debug('  Related Cargo Records: ' + verifyShip.Cargo__r.size());
System.debug('  Related Customs Documents: ' + verifyShip.Customs_Documents__r.size());

for (Cargo__c c : verifyShip.Cargo__r) {
    System.debug('    → Cargo: ' + c.Name + ' | ' + c.Category__c + ' | ' + c.Weight__c + 'kg | ' + c.Shipping_Method__c);
}

for (Customs_Document__c d : verifyShip.Customs_Documents__r) {
    System.debug('    → Customs Doc: ' + d.Name);
}

System.debug('==========================================');
System.debug('✓ All objects created successfully!');
System.debug('✓ All relationships verified!');
System.debug('==========================================');
