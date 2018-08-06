trigger ProductTableTrigger on Product_Table__c (before insert) {
    if (trigger.isInsert && trigger.isBefore) {
        ProductTableTriggerHandler productTableHandler = new ProductTableTriggerHandler();
    	productTableHandler.beforeInsert(trigger.new);
    }
}