global class DeleteOrders implements 
    Database.Batchable<sObject>, Database.Stateful {
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id, Status__c FROM Order__c WHERE Status__c = \'Draft\'');
    }
  global void execute(Database.batchableContext info, List<Order__c> ordList){
      delete ordList;      
  }
    global void finish(Database.BatchableContext bc){
      System.debug('Delete all Order__c records' + Date.today());
    }  
}