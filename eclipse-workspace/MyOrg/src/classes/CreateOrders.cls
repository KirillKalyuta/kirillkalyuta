global class CreateOrders implements 
    Database.Batchable<sObject>, Database.Stateful {
        
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT ID, Name FROM Contact');
    }
	global void execute(Database.batchableContext bc, List<Contact> contList){
      List<Order__c> ordList = new List<Order__c>();
      if(contList!=null && !contList.isEmpty()){
          for(Contact con : contList){
              for(Integer i = 0; i<10; i++){
                   ordList.add(new Order__c(Contact__c = con.Id, Status__c = 'Draft'));
              }
          }
          insert ordList;
          } 
		  else {
          	System.debug('You do not have Contact');
		}
	}
	
    global void finish(Database.BatchableContext bc){
        System.debug('Created new 10 Orders for Contacts' + Date.today());
    }  
}