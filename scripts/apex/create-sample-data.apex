// Comprehensive Test Data Generator for Intergalactic Freight & Trade Corp
// This script creates 10 Shipment records with related Cargo and Customs Documents
// Following data security fundamentals with proper relationships

// Get existing related records
List<Account> accounts = [SELECT Id FROM Account LIMIT 5];
List<Contact> contacts = [SELECT Id, AccountId FROM Contact LIMIT 5];
List<Opportunity> opportunities = [SELECT Id, AccountId FROM Opportunity LIMIT 5];
List<User> users = [SELECT Id FROM User WHERE IsActive = true LIMIT 3];

// Planetary systems for variety
List<String> planetarySystems = new List<String>{
    'Sol System', 'Alpha Centauri', 'Sirius System', 
    'Andromeda Sector', 'Betelgeuse System', 'Vega Colony', 'Proxima System'
};

// Create 10 Shipments with proper relationships
List<Shipment__c> shipments = new List<Shipment__c>();

shipments.add(new Shipment__c(
    Name = 'SHIP-2025-0001',
    Planetary_System__c = 'Sol System',
    Departure_Date__c = Date.today().addDays(5),
    ETA__c = Date.today().addDays(12),
    Discount__c = 5.00,
    AccountId__c = accounts[0].Id,
    ContactId__c = contacts[0].Id,
    OpportunityId__c = opportunities[0].Id,
    Assigned_Agent__c = users[1].Id
));

shipments.add(new Shipment__c(
    Name = 'SHIP-2025-0002',
    Planetary_System__c = 'Alpha Centauri',
    Departure_Date__c = Date.today().addDays(3),
    ETA__c = Date.today().addDays(45),
    Discount__c = 10.00,
    AccountId__c = accounts[1].Id,
    ContactId__c = contacts[1].Id,
    OpportunityId__c = opportunities[1].Id,
    Assigned_Agent__c = users[2].Id
));

shipments.add(new Shipment__c(
    Name = 'SHIP-2025-0003',
    Planetary_System__c = 'Sirius System',
    Departure_Date__c = Date.today().addDays(7),
    ETA__c = Date.today().addDays(38),
    Discount__c = 0.00,
    AccountId__c = accounts[2].Id,
    ContactId__c = contacts[2].Id,
    OpportunityId__c = opportunities[2].Id,
    Assigned_Agent__c = users[1].Id
));

shipments.add(new Shipment__c(
    Name = 'SHIP-2025-0004',
    Planetary_System__c = 'Andromeda Sector',
    Departure_Date__c = Date.today().addDays(2),
    ETA__c = Date.today().addDays(90),
    Discount__c = 15.00,
    AccountId__c = accounts[3].Id,
    ContactId__c = contacts[3].Id,
    OpportunityId__c = opportunities[3].Id,
    Assigned_Agent__c = users[2].Id
));

shipments.add(new Shipment__c(
    Name = 'SHIP-2025-0005',
    Planetary_System__c = 'Betelgeuse System',
    Departure_Date__c = Date.today().addDays(10),
    ETA__c = Date.today().addDays(52),
    Discount__c = 8.50,
    AccountId__c = accounts[4].Id,
    ContactId__c = contacts[4].Id,
    OpportunityId__c = opportunities[4].Id,
    Assigned_Agent__c = users[1].Id
));

shipments.add(new Shipment__c(
    Name = 'SHIP-2025-0006',
    Planetary_System__c = 'Vega Colony',
    Departure_Date__c = Date.today().addDays(15),
    ETA__c = Date.today().addDays(35),
    Discount__c = 12.00,
    AccountId__c = accounts[0].Id,
    ContactId__c = contacts[0].Id,
    OpportunityId__c = opportunities[0].Id,
    Assigned_Agent__c = users[2].Id
));

shipments.add(new Shipment__c(
    Name = 'SHIP-2025-0007',
    Planetary_System__c = 'Proxima System',
    Departure_Date__c = Date.today().addDays(1),
    ETA__c = Date.today().addDays(22),
    Discount__c = 5.00,
    AccountId__c = accounts[1].Id,
    ContactId__c = contacts[1].Id,
    OpportunityId__c = opportunities[1].Id,
    Assigned_Agent__c = users[1].Id
));

shipments.add(new Shipment__c(
    Name = 'SHIP-2025-0008',
    Planetary_System__c = 'Sol System',
    Departure_Date__c = Date.today().addDays(20),
    ETA__c = Date.today().addDays(28),
    Discount__c = 0.00,
    AccountId__c = accounts[2].Id,
    ContactId__c = contacts[2].Id,
    OpportunityId__c = opportunities[2].Id,
    Assigned_Agent__c = users[2].Id
));

shipments.add(new Shipment__c(
    Name = 'SHIP-2025-0009',
    Planetary_System__c = 'Alpha Centauri',
    Departure_Date__c = Date.today().addDays(8),
    ETA__c = Date.today().addDays(50),
    Discount__c = 20.00,
    AccountId__c = accounts[3].Id,
    ContactId__c = contacts[3].Id,
    OpportunityId__c = opportunities[3].Id,
    Assigned_Agent__c = users[1].Id
));

shipments.add(new Shipment__c(
    Name = 'SHIP-2025-0010',
    Planetary_System__c = 'Sirius System',
    Departure_Date__c = Date.today().addDays(12),
    ETA__c = Date.today().addDays(40),
    Discount__c = 7.50,
    AccountId__c = accounts[4].Id,
    ContactId__c = contacts[4].Id,
    OpportunityId__c = opportunities[4].Id,
    Assigned_Agent__c = users[2].Id
));

// Insert shipments
insert shipments;
System.debug('✅ Created ' + shipments.size() + ' Shipment records');

// Create Cargo items for each shipment (2-3 per shipment)
List<Cargo__c> allCargo = new List<Cargo__c>();

// Cargo categories and shipping methods for variety
List<String> categories = new List<String>{'Electronics', 'Food & Beverages', 'Machinery', 'Textiles', 'Chemicals', 'Medical Supplies', 'Other'};
List<String> shippingMethods = new List<String>{'Air Freight', 'Sea Freight', 'Ground Transport', 'Rail Freight', 'Express Delivery'};

Integer cargoCounter = 1;
for(Shipment__c ship : shipments) {
    // Create 2-3 cargo items per shipment
    Integer numCargo = Math.mod(Integer.valueOf(Math.random() * 100), 2) + 2; // 2 or 3 items
    
    for(Integer i = 0; i < numCargo; i++) {
        allCargo.add(new Cargo__c(
            Name = 'CARGO-' + String.valueOf(cargoCounter).leftPad(4, '0'),
            Shipment__c = ship.Id,
            Category__c = categories[Math.mod(cargoCounter, categories.size())],
            Weight__c = (Math.random() * 5000) + 100, // Random weight between 100-5100 kg
            Shipping_Method__c = shippingMethods[Math.mod(cargoCounter, shippingMethods.size())]
        ));
        cargoCounter++;
    }
}

insert allCargo;
System.debug('✅ Created ' + allCargo.size() + ' Cargo records');

// Create Customs Documents (1-2 per shipment)
List<Customs_Document__c> customsDocs = new List<Customs_Document__c>();
Integer docCounter = 1;

for(Shipment__c ship : shipments) {
    // Get cargo for this shipment
    List<Cargo__c> shipmentCargo = new List<Cargo__c>();
    for(Cargo__c cargo : allCargo) {
        if(cargo.Shipment__c == ship.Id) {
            shipmentCargo.add(cargo);
        }
    }
    
    // Create 1-2 customs docs per shipment
    Integer numDocs = Math.mod(Integer.valueOf(Math.random() * 100), 2) + 1; // 1 or 2 docs
    
    for(Integer i = 0; i < numDocs && i < shipmentCargo.size(); i++) {
        customsDocs.add(new Customs_Document__c(
            Name = 'CUSTOMS-DOC-' + String.valueOf(docCounter).leftPad(4, '0'),
            Shipment__c = ship.Id,
            Cargo__c = shipmentCargo[i].Id
        ));
        docCounter++;
    }
}

insert customsDocs;
System.debug('✅ Created ' + customsDocs.size() + ' Customs Document records');

// Summary output
System.debug('========================================');
System.debug('📊 DATA CREATION SUMMARY');
System.debug('========================================');
System.debug('Shipments Created: ' + shipments.size());
System.debug('Cargo Items Created: ' + allCargo.size());
System.debug('Customs Documents Created: ' + customsDocs.size());
System.debug('========================================');
System.debug('🔒 SECURITY & RELATIONSHIPS:');
System.debug('- All shipments linked to Accounts');
System.debug('- All shipments linked to Contacts');
System.debug('- All shipments linked to Opportunities');
System.debug('- All shipments assigned to Users (Agents)');
System.debug('- All cargo items linked to Shipments (Master-Detail)');
System.debug('- All customs docs linked to Shipments & Cargo (Master-Detail)');
System.debug('========================================');

// Display sample records for verification
System.debug('📦 Sample Shipment: ' + shipments[0].Name + ' (' + shipments[0].Planetary_System__c + ')');
System.debug('📦 Sample Cargo: ' + allCargo[0].Name + ' (' + allCargo[0].Category__c + ', ' + allCargo[0].Weight__c + ' kg)');
System.debug('📦 Sample Customs Doc: ' + customsDocs[0].Name);
