public with sharing class productSearch {
    
    @TestVisible 
    static IProductSelector productSelector = new ProductSelector(); 
    
    @AuraEnabled(cacheable=true)
    public static List<Product2> searchProducts(String searchKey) {
        // Prevent SOQL injection by escaping special characters
        String searchTerm = '%' + String.escapeSingleQuotes(searchKey) + '%';
// Perform the SOQL query
        return productSelector.searchProduct(searchTerm);
    }
}