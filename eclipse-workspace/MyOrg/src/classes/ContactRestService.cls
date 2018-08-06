@RestResource(urlMapping='/ContactRestService/*')
global with sharing class ContactRestService {
    
    @HttpPost
    global static List<Id> doPost(String name,
        String website, String phone, String firstName, String lastName, String email) {
        List<String> idList = new List<String>();    
        Account acc = new Account();
        	acc.Name = name;
        	acc.Website = website;
        	acc.Phone = phone; 
        	insert acc; 
        Contact cont = new Contact();
        	cont.FirstName = firstName;
        	cont.LastName = lastName;
        	cont.Email = email;
        	cont.Phone = phone; 
        	cont.AccountId = acc.id;        
        	idList.add(acc.id);
        	idList.add(cont.id);          
		return idList;
        }
}