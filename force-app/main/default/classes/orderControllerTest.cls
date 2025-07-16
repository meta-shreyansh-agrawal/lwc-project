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
        mocks.when(mockSelector.getPaginatedOrders(1,2)).thenReturn(responseOrders);
        mocks.when(mockSelector.getOrderCount()).thenReturn(1); 
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

    @isTest
    static void testPlaceOrder(){
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        IProductSelector mockSelector = (IProductSelector) mocks.mock(IProductSelector.class);
        fflib_SObjectUnitOfWork mockUow = (fflib_SObjectUnitOfWork) mocks.mock(fflib_SObjectUnitOfWork.class);

        // Sample Mock Data

        Id fakeOrderId = fflib_IdGenerator.generate(PurchaseOrder__c.SObjectType);
        Id fakeProductId = fflib_IdGenerator.generate(Product2.SObjectType);
        Id fakeOrderItemId = fflib_IdGenerator.generate(PurchaseOrderLineItem__c.SObjectType);
        PurchaseOrder__c order = new PurchaseOrder__c(Id=fakeOrderId,Name = 'Product1');
        List<Product2> products = new List<Product2>{
            new Product2(
                    Id = fakeProductId,
                    Name = 'Product1',
                    Available_Units__c = 100
                ) 
        };
        List<PurchaseOrderLineItem__c> orderLineItems = new List<PurchaseOrderLineItem__c>{
            new PurchaseOrderLineItem__c(
                Id = fakeOrderItemId,
                Name = 'Item1',
                Product__c = products[0].Id,
                Quantity__c = 5
            )
        }; 

        Set<Id> idSet = new Set<Id>(); 
        idSet.add(products[0].Id);

        // Stubbing
        mocks.startStubbing(); 
        mocks.when(mockSelector.getProductsByIdSet(idSet)).thenReturn(products);
        mocks.stopStubbing();

        Test.startTest();
        orderController.productSelector = mockSelector; 
        orderController.uow = mockUow;
        orderController.placeOrder(order,orderLineItems);
        Test.stopTest(); 

        // Assertions 

        System.assertEquals(95, products[0].Available_Units__c,'Avaliable Units should be reduced');
    }
}