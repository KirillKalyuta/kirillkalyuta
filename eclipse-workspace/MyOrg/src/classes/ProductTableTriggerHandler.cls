public with sharing class ProductTableTriggerHandler {
    
    List<Warehouse__c> newWarList = new List<Warehouse__c>();
    
    public void beforeInsert(List<Product_Table__c> productTables) {        
        
        List<Warehouse__c> warList = [
            SELECT Id, Name, Period_Start__c, Period_End__c 
            From Warehouse__c 
            WHERE Period_Start__c != null 
            	AND Period_End__c != null
        ];
        List<Org_Configuration__c> orgList = [
            SELECT Id, Period_Term__c 
            FROM Org_Configuration__c
        ];
        
        for (Product_Table__c prod : productTables) {
            if (prod.Added_Date__c == null) {
                prod.Added_Date__c = Date.today();
            }
            if (!warList.isEmpty()) {
                for (Warehouse__c ware : warList) {
                    if (ware.Period_Start__c <= prod.Added_Date__c && ware.Period_End__c >= prod.Added_Date__c) {
                        prod.Warehouse__c = ware.Id;
                        break;
                    } else {  
                        CreateWarehouse(prod);                  
                    }
                }
            } else {
                CreateWarehouse(prod);          
            }            
        } 
        insert newWarList;
        for (Product_Table__c prod : productTables) {
            for (Warehouse__c ware : newWarList) {
                if (ware.Period_Start__c <= prod.Added_Date__c && ware.Period_End__c >= prod.Added_Date__c) {
                    prod.Warehouse__c = ware.Id;
                    break;
                }
            }
        }
    }
    private void CreateWarehouse(Product_Table__c prod) {
        Warehouse__c wareNew = new Warehouse__c(
            Name = 'Warehouse' + Date.valueOf(prod.Added_Date__c) + ' ' + prod.Added_Date__c.addDays((Integer)Org_Configuration__c.getInstance().Period_Term__c),
            Period_Start__c = prod.Added_Date__c,
            Period_End__c = prod.Added_Date__c.addDays((Integer)Org_Configuration__c.getInstance().Period_Term__c)
        );                    
        newWarList.add(wareNew);
    }    
}