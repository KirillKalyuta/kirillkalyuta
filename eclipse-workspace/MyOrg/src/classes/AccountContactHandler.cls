@RestResource(urlMapping='/AccountContactHandler')
global class AccountContactHandler {

    @HttpGet
    global static void getAccountsIdAndContactsId() {
        RestRequest requestContext = RestContext.request;
        RestResponse res = RestContext.response;
        Map<String, String> requestParam = requestContext.params;
        
        Date paramDateTime;
        if(requestContext.params.containsKey('date')){
            paramDateTime = Date.valueOf(requestContext.params.get('date'));
        }
        
        Map<String, Set<Id>> objectListIdMap = new Map<String, Set<Id>>();

        if (paramDateTime != null){
            Map<Id,Account> accounts = new Map<Id,Account>([SELECT Id
                                                            FROM Account 
                                                            Where CreatedDate = : paramDateTime]);

            Map<Id,Contact> contacts = new Map<Id,Contact>([SELECT Id
                                                            FROM Contact 
                                                            Where CreatedDate = :paramDateTime]);

            objectListIdMap.put('accountIds', accounts.keySet());
            objectListIdMap.put('contactIds', contacts.keySet());
        }

        res.responseBody = Blob.valueOf(JSON.serialize(objectListIdMap));
        res.statusCode = 200;
    }
    
    /*@HttpPost
    global static void getAccountsIdAndContactsIdOfParam() {

        RestRequest requestContext = RestContext.request;
        RestResponse res = RestContext.response;
        Map<String, Set<Id>> objectListIdMap = new Map<String, Set<Id>>();

        List<AccountWrapper> accountWrappers = (List<AccountWrapper>)JSON.deserialize(requestContext.requestBody.toString(), List<AccountWrapper>.class);
        if( accountWrappers != null){
            Set<String> accountsName = new Set<String>();
            Set<String> contactsName = new Set<String>();
            Set<Id> contactsId = new Set<Id>();

            for(AccountWrapper currentAcc : accountWrappers){
                accountsName.add(currentAcc.name);
                for(AccountWrapper.Contacts currContact : currentAcc.contacts){
                    contactsName.add(currContact.LastName);
                }
            }

            Map<Id,Account> accounts = new Map<Id,Account>([SELECT Name, (Select Id, FirstName, LastName, Email From Contacts Where LastName IN :contactsName)
                                                            FROM Account 
                                                            Where Name IN :accountsName]);

            for(Account currentAcc : accounts.values()){
                for(Contact currentCon : currentAcc.Contacts){
                    contactsId.add(currentCon.Id);
                }
            }
            
            objectListIdMap.put('accountIds', accounts.keySet());
            objectListIdMap.put('contactIds', contactsId);
            res.responseBody = Blob.valueOf(JSON.serialize(objectListIdMap));
            res.statusCode = 200;
        }
    }*/     
}