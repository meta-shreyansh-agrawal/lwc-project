@isTest
public with sharing class ParkLocatorTest {
    
    @isTest
    static void testCallout(){
        Test.setMock(WebServiceMock.class, new ParkServiceMock());

        String country = 'United States'; 
        System.assertEquals(new List<String>{'Yosemite','Sequoia','Crater Lake'},ParkLocator.country(country)); 
    }
}