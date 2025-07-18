trigger accountTestTrigger on Account (before insert, before update) {
    // for(Account a: Trigger.new) {
    //     List<Contact> contacts = [select id, salutation, firstname, lastname, email from Contact where accountId = :a.Id];
    //     for(Contact c: contacts) {
    //         System.debug('Contact Id[' + c.Id + '], FirstName[' + c.firstname + '],
    //         LastName[' + c.lastname +']');
    //         c.Description=c.salutation + ' ' + c.firstName + ' ' + c.lastname;
    //         update c;
    //     }
    // }

    //updated and optimized
    List<Contact> contactToUpdate = new List<Contact>();
    List<Id> accountIds = new List<Id>(); 

    for(Account a: Trigger.new) {
        accountIds.add(a.Id);
    }

    List<Contact> contacts = [select id, salutation, firstname, lastname, email from Contact where accountId in :accountIds]; 
        
    for(Contact c: contacts) {
        System.debug('Contact Id[' + c.Id + '], FirstName[' + c.firstname + '], LastName[' + c.lastname +']');
        c.Description=c.salutation + ' ' + c.firstName + ' ' + c.lastname;
        contactToUpdate.add(c);
    }

    update contactToUpdate;
}