@isTest 
private class AccountManagerTest {

        @isTest
        static void testGetAccount(){
            Account a = new Account(name='Test account');
            insert a; 
            Contact c = new Contact(AccountId = a.id, FirstName='Test',LastName='Test'); 
            insert c; 
            
            RestRequest request = new RestRequest(); 
            request.requestUri = 'https://yourInstance.salesforce.com/services/apexrest/Accounts/'+a.id+'/contacts';
            request.httpMethod = 'GET'; 
            RestContext.request = request; 
            Account myAcct = AccountManager.getAccount(); 

            System.assert(myAcct!=null); 
            System.assertEquals('TestAccount', myAcct.name); 
        }
}