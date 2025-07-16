@IsTest
private class productSearchTest {
    
    @IsTest
    static void testSearchProductWithMock(){
        //Create Mock 
        fflib_ApexMocks mocks = new fflib_ApexMocks();
        IProductSelector mockSelector = (IProductSelector) mocks.mock(IProductSelector.class);

        // Sample Mock Data
        List<Product2> responseProducts = new List<Product2>{
            new Product2(Name = 'Product1') 
        };

        // Stubbing
        mocks.startStubbing();
        mocks.when(mockSelector.searchProduct('%Product%'))
        .thenReturn(responseProducts);
        mocks.stopStubbing(); 
        
        // Start Test
        Test.startTest(); 
        productSearch.productSelector = mockSelector; 
        List<Product2> result = productSearch.searchProducts('Product');
        Test.stopTest(); 

        //Assertion
        System.assertEquals(1, result.size()); 
        System.assertEquals('Product1', result[0].Name); 

    }
}