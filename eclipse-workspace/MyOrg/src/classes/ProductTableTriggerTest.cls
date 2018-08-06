@isTest(SeeAllData=false)
public class ProductTableTriggerTest {
	@isTest static void MyProductTableTriggerTest() {
        date startDate = date.today();
        date endDate = startDate.addDays(5);
        Org_Configuration__c org = new Org_Configuration__c(
            Period_Term__c = 10
        );
        insert org;
        Product_Table__c prod3 = new Product_Table__c(
        	Name = 'TestProdact1',
            Unit_Price__c = 100            
        );
        insert prod3;       
        Product_Table__c prod2 = new Product_Table__c(
        	Name = 'TestProdact1',
            Unit_Price__c = 100,
            Added_Date__c = startDate.addDays(16)
        );
        insert prod2;
        Product_Table__c prod1 = new Product_Table__c(
        	Name = 'TestProdact1',
            Unit_Price__c = 100,
            Added_Date__c = startDate.addDays(2)
        );
        insert prod1;
        
        
        Test.startTest(); 
        system.assertEquals(2, [SELECT Count() From Warehouse__c]);        
        Test.stopTest();
        
        

    }  
}