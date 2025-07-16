@isTest
private class orderControllerTest {

    @isTest
    static void testGetPreviousOrders() {
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        IPurchaseOrderSelector mockSelector = (IPurchaseOrderSelector) mocks.mock(IPurchaseOrderSelector.class);

        // Sample Mock Data
        List<PurchaseOrder__c> responseOrders = new List<PurchaseOrder__c>{
            new PurchaseOrder__c(Name = 'Product1') 
        };

        // Stubbing
        mocks.startStubbing();
        mocks.when(mockSelector.getPaginatedOrders(1,2))
        .thenReturn(responseOrders);
        mocks.when(mockSelector.getOrderCount())
        .thenReturn(1); 
        mocks.stopStubbing(); 
        
        // Start Test
        Test.startTest(); 
        orderController.purchaseOrderSelector = mockSelector; 
        Map<String, Object> result = orderController.getPrevoiusOrders(1,1);
        Integer totalRecords = (Integer)result.get('totalRecords');
        Integer totalPages = (Integer)result.get('totalPages');
        Test.stopTest(); 

        //Assertion
        System.AssertEquals(1, totalRecords);
        System.AssertEquals(1, totalPages); 
    }
}