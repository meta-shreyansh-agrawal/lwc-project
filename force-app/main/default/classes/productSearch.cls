public with sharing class productSearch {
     @AuraEnabled(cacheable=true)
    public static List<Product2> searchProducts(String searchKey) {
        // Prevent SOQL injection by escaping special characters
        String searchTerm = '%' + String.escapeSingleQuotes(searchKey) + '%';
// Perform the SOQL query
        return new ProductSelector().searchProduct(searchTerm);
    }
}