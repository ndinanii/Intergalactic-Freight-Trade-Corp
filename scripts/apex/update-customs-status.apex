// Update existing Customs Documents with Status values
List<Customs_Document__c> customsDocs = [
    SELECT Id, Name 
    FROM Customs_Document__c 
    WHERE Name LIKE 'CUSTOMS-DOC-%' 
    ORDER BY Name
];

if (customsDocs.isEmpty()) {
    System.debug('No customs documents found to update.');
} else {
    List<String> statusValues = new List<String>{
        'Pending', 'Approved', 'Rejected', 'Under Review', 'Expired'
    };
    
    // Assign statuses with a good distribution
    for (Integer i = 0; i < customsDocs.size(); i++) {
        // Distribute statuses: More Approved and Pending, fewer Rejected and Expired
        if (Math.mod(i, 5) == 0) {
            customsDocs[i].Status__c = 'Approved';
        } else if (Math.mod(i, 5) == 1) {
            customsDocs[i].Status__c = 'Approved';
        } else if (Math.mod(i, 5) == 2) {
            customsDocs[i].Status__c = 'Pending';
        } else if (Math.mod(i, 5) == 3) {
            customsDocs[i].Status__c = 'Under Review';
        } else {
            customsDocs[i].Status__c = 'Rejected';
        }
    }
    
    update customsDocs;
    
    System.debug('✅ Updated ' + customsDocs.size() + ' Customs Document records with Status values');
    
    // Show distribution
    Map<String, Integer> statusCount = new Map<String, Integer>();
    for (Customs_Document__c doc : customsDocs) {
        Integer count = statusCount.containsKey(doc.Status__c) ? statusCount.get(doc.Status__c) : 0;
        statusCount.put(doc.Status__c, count + 1);
    }
    
    System.debug('\n📊 Status Distribution:');
    for (String status : statusCount.keySet()) {
        System.debug('   ' + status + ': ' + statusCount.get(status) + ' documents');
    }
}
