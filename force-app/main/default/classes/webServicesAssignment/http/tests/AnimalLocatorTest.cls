@isTest
public class AnimalLocatorTest {
    @isTest
    static void testAnimalLocator(){
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock()); 

        String response = AnimalLocator.getAnimalNameById(2); 
        
        Assert.areEqual(response, 'bear'); 
    }  
}