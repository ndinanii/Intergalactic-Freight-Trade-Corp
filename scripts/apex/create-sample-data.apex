// Create sample Account, Contact, and Opportunity for testing

// Create Account
Account acc = new Account(
    Name = 'Intergalactic Trading Co.',
    Type = 'Customer',
    Industry = 'Transportation'
);
insert acc;
System.debug('Created Account: ' + acc.Id);

// Create Contact
Contact con = new Contact(
    FirstName = 'John',
    LastName = 'Spacecraft',
    Email = 'john.spacecraft@example.com',
    Phone = '+1-555-0123',
    AccountId = acc.Id
);
insert con;
System.debug('Created Contact: ' + con.Id);

// Create Opportunity
Opportunity opp = new Opportunity(
    Name = 'Q4 2025 Shipment Deal',
    StageName = 'Prospecting',
    Amount = 50000,
    CloseDate = Date.today().addDays(90),
    AccountId = acc.Id
);
insert opp;
System.debug('Created Opportunity: ' + opp.Id);

System.debug('===== SAMPLE DATA CREATED =====');
System.debug('Account ID: ' + acc.Id);
System.debug('Contact ID: ' + con.Id);
System.debug('Opportunity ID: ' + opp.Id);
