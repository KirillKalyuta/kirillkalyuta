public with sharing class CurrencyExchangeTaskHandlerAccount {
    public static void  CurrencyExchangeHandlerAccount(List<Account> listOfAccounts){
       
        List<Currency_Rate__c> currencyRates = [SELECT  Id, Name, Rate__c
                                                FROM Currency_Rate__c
                                                ];
        System.debug('$$$$$ currencyRates ' + currencyRates);

        Map<String, Decimal> mapCurrencyToRate = new Map<String, Decimal>();

        for (Currency_Rate__c rate : currencyRates) {
            String nameOfCurrency = rate.Name;
            Decimal rateOfCurrency = rate.Rate__c;
            mapCurrencyToRate.put(nameOfCurrency, rateOfCurrency);
            System.debug('$$$$$ mapCurrencyToRate ' + mapCurrencyToRate);
        }
        
        List<Account> listOfAccountsToUpdate = new List<Account>();
        List<Contact> listOfContactsToUpdate = new List<Contact>();
        Decimal rateUSD = mapCurrencyToRate.get('USD');
        Decimal rateJPY = mapCurrencyToRate.get('JPY');
		listOfAccounts = [SELECT Id, Name, Salary__c, Salary_in_currency__c, Currency_Type__c,
                                        (SELECT Id, Name, Salary__c, Salary_in_currency__c, Currency_Type__c
                                        FROM Contacts)
                                        FROM Account
                                        WHERE Id IN :Trigger.new];
        System.debug('$$$$$ listOfAccounts ' + listOfAccounts);

        List<Contact> listContacts = new List<Contact>();

        for (Account account : listOfAccounts) {
            Decimal sumSalary = 0;
            listContacts = account.Contacts;
            System.debug('$$$$$ listOfContacts ' + listContacts);

            //Account sum salary
            for (Contact contact : listContacts) {

                //Check null fields
                if (contact.Salary__c == null) {
                    continue;
                }

                //Account sum salary
                sumSalary += contact.Salary__c;
            }

            account.Salary__c = sumSalary;
            System.debug('$$$$$ account.Salary__c ' + account.Salary__c);

            //EUR exchange
            if (account.Currency_Type__c == 'EUR') {
                account.Salary_in_currency__c = account.Salary__c;
            }

            //USD exchange
            if (account.Currency_Type__c == 'USD') {
                account.Salary_in_currency__c = rateUSD * account.Salary__c;
            }

            //JPY exchange
            if (account.Currency_Type__c == 'JPY') {
                account.Salary_in_currency__c = rateJPY * account.Salary__c;
            }

            listOfAccountsToUpdate.add(account);
            System.debug('$$$$$ listOfAccountsToUpdate ' + listOfAccountsToUpdate);
            map<id, Account> accIdMap = new map<id, Account>(listOfAccountsToUpdate);
            for (Account cur : (List<Account>)Trigger.new) {
                Account v = accIdMap.get(cur.Id);
                cur.Salary_in_currency__c = v.Salary_in_currency__c;
            }
            

        }
    }
}