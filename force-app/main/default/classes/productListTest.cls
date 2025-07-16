@isTest
private class productListTest {

    @isTest
    static void testGetPaginatedProduct() {
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        IProductSelector mockSelector = (IProductSelector) mocks.mock(IProductSelector.class);

        // Sample Mock Data
        List<Product2> responseProducts = new List<Product2>{
            new Product2(Name = 'Product1') 
        };

        // Stubbing
        mocks.startStubbing();
        mocks.when(mockSelector.getPaginatedProducts(1,2))
        .thenReturn(responseProducts);
        mocks.when(mockSelector.getProductCount())
        .thenReturn(1); 
        mocks.stopStubbing(); 
        
        // Start Test
        Test.startTest(); 
        productList.productSelector = mockSelector; 
        Map<String, Object> result = productList.getPaginatedProducts(1,1);
        Integer totalRecords = (Integer)result.get('totalRecords');
        Integer totalPages = (Integer)result.get('totalPages');
        Test.stopTest(); 

        //Assertion
        System.AssertEquals(1, totalRecords);
        System.AssertEquals(1, totalPages); 

    }
}