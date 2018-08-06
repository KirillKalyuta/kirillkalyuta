@isTest(SeeAllData=false)
public class TestLeadTrigger {
    @isTest static void LeadTest() {
        Campaign camp1 = new Campaign(
            Name = 'Facebook'
        );
		insert camp1;
        Campaign camp2 = new Campaign(
            Name = 'Facebook_06_18',                      
            ParentId = camp1.Id,
            StartDate = date.valueOf('2018-06-01'),
            EndDate = date.valueOf('2018-06-30')          
        );        
		insert camp2;
        Lead lead1 = new Lead(            
        	LastName = 'Mike',
        	Company = 'Pip',
        	LeadSource = 'Facebook'
        );
        
        Lead lead2 = new Lead(
        	LastName = 'Jak',
        	Company = 'NUN',
        	LeadSource = 'Instagram'
        );
        
        	Test.startTest();
            Database.SaveResult result = Database.insert(lead1, false);
            Database.SaveResult result1 = Database.insert(lead2, false);
            Test.stopTest();
            
            system.debug(result);        
            System.assertEquals(result.isSuccess(), true);

            system.debug(result1);   
            System.assertEquals(result1.getErrors()[0].getMessage(), 'My Error');
            System.assertEquals(result1.isSuccess(), false);
        

    }   

}