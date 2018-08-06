global class CurrencyExchangeTaskBatch implements Database.Batchable<SObject> {

    global Database.QueryLocator start(Database.BatchableContext bc) {

        return Database.getQueryLocator('SELECT Id, Name, Salary__c, Salary_in_currency__c, Currency_Type__c, Account.Id, Account.Salary__c, Account.Currency_Type__c ' +
                                        'FROM Contact');

    }

    global void execute(Database.BatchableContext bc, List<Contact> contacts) {

        //Retrieving currency rates
        List<Currency_Rate__c> currencyRates = [SELECT  Id, Name, Rate__c
                                                FROM Currency_Rate__c
                                                ];

        Map<String, Decimal> mapCurrencyToRate = new Map<String, Decimal>();

        for (Currency_Rate__c rate : currencyRates) {
            String nameOfCurrency = rate.Name;
            Decimal rateOfCurrency = rate.Rate__c;
            mapCurrencyToRate.put(nameOfCurrency, rateOfCurrency);
        }

        //Updating accounts and contacts
        List<Account> listOfAccountsToUpdate = new List<Account>();
        List<Contact> listOfContactsToUpdate = new List<Contact>();
        Decimal rateUSD = mapCurrencyToRate.get('USD');
        Decimal rateJPY = mapCurrencyToRate.get('JPY');

        //Updating contacts
        List<Id> listOfAccountsIds = new List<Id>();

        for (Contact contact : contacts) {

            //Check null fields
            if (contact.Salary__c == null) {
                continue;
            }

            //Check null fields
            if (contact.Currency_Type__c == null) {
                contact.Currency_Type__c = 'EUR';
            }

            //EUR exchange
            if (contact.Currency_Type__c == 'EUR') {
                contact.Salary_in_currency__c = contact.Salary__c;
            }

            //USD exchange
            if (contact.Currency_Type__c == 'USD') {
                contact.Salary_in_currency__c = rateUSD * contact.Salary__c;
            }

            //JPY exchange
            if (contact.Currency_Type__c == 'JPY') {
                contact.Salary_in_currency__c = rateJPY * contact.Salary__c;
            }

            if (contact.AccountId != null) {
                listOfAccountsIds.add(contact.AccountId);
            }

            listOfContactsToUpdate.add(contact);
        }

        update listOfContactsToUpdate;

        //Updating accounts
        List<Account> listOfAccounts = [SELECT Id, Name, Salary__c, Salary_in_currency__c, Currency_Type__c,
                                        (SELECT Id, Name, Salary__c, Salary_in_currency__c, Currency_Type__c
                                        FROM Contacts)
                                        FROM Account
                                        WHERE Id IN :listOfAccountsIds];

        List<Contact> listOfContacts = new List<Contact>();

        for (Account account : listOfAccounts) {
            Decimal sumSalary = 0;
            listOfContacts = account.Contacts;

            //Account sum salary
            for (Contact contact : listOfContacts) {

                //Check null fields
                if (contact.Salary__c == null) {
                    continue;
                }

                //Account sum salary
                sumSalary += contact.Salary__c;
            }

            account.Salary__c = sumSalary;

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

        }

        update listOfAccountsToUpdate;

    }

    global void finish(Database.BatchableContext bc) {

    }

}