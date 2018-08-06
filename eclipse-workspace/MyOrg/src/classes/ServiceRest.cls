@RestResource(urlMapping='/ServiceRest/*')
global with sharing class ServiceRest {
    @HttpGet
    global static void requestGet() {

        RestRequest requestContext = RestContext.request;
        RestResponse responseContext = RestContext.response;
        Map<String, String> requestParams = requestContext.params;

        Date dateCreate;
        if (requestParams.containsKey('dateCreate')) {
            dateCreate = date.valueOf(requestParams.get('dateCreate'));
        }

        Set<Id> contactsId = new Set<Id>();
        Set<Id> accountsId = new Set<Id>();

        if(dateCreate == null) {
            for (Contact cont : [SELECT Id FROM Contact]) {
                contactsId.add(cont.Id); 
            }
            for (Account acc : [SELECT Id FROM Account]) {
                accountsId.add(acc.Id);
            }
        } else {
            for (Contact cont : [SELECT Id, CreatedDate
                                FROM Contact
                                WHERE DAY_ONLY(CreatedDate) =: dateCreate ]) {
                contactsId.add(cont.Id);
            }
            for (Account acc : [SELECT Id, CreatedDate
                               FROM Account
                               WHERE DAY_ONLY(CreatedDate) =: dateCreate ]) {
                accountsId.add(acc.Id);
            }
        }

        List<Object> dateCreatedList = new List<Object>();

        dateCreatedList.add(contactsId);
        dateCreatedList.add(accountsId);

        responseContext.responseBody = Blob.valueOf(JSON.serialize(dateCreatedList));
        responseContext.statusCode = 200;

    }
    
    
   @HttpPost
	global static void createObj() {
             
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;   
        response.addHeader('Content-Type','application/json');
        
        try{
            JSON2Apex jsonBody = JSON2Apex.parse(request.requestBody.toString());
            List<Account> accInsertList = new  List<Account>();
            List<Contact> contInsertList = new  List<Contact>();
            Set<Id> accIds = new Set<Id>();
            Set<Id> contIds = new Set<Id>();
        
        for (Integer i=0; i<jsonBody.Account.size(); i++) {
              Account acc = new Account(
               Name = jsonBody.Account[i].name
              );
            accInsertList.add(acc);
        
            if (jsonBody.Account[i].Contact.size() != null) {
              for (Integer j=0; j<jsonBody.Account[i].Contact.size(); j++) {
				Contact con = new Contact(
                FirstName = jsonBody.Account[i].Contact[j].FirstName,
      			LastName = jsonBody.Account[i].Contact[j].LastName
                );
                contInsertList.add(con);
              }
            }     
            
         }    
       upsert contInsertList;
       upsert accInsertList; 
            
       if (!accInsertList.isEmpty()) {
           for (Account acc : accInsertList) {
              accIds.add(acc.Id); 
           }
       }
            
       if (!contInsertList.isEmpty()) {
           for (Contact con : contInsertList) {
              contIds.add(con.Id); 
           }
       }    
           
        response.responseBody=Blob.valueOf('account' + JSON.serialize(accIds)  + '\n' + 'contact' + JSON.serialize(contIds));
        response.statusCode = 201;
     } catch (Exception e) {
              system.debug(e);
      
 		}
	}
}