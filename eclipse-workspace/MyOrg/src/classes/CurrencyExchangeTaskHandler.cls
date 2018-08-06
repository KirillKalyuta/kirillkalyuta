public with sharing class CurrencyExchangeTaskHandler {
    public static void  CurrencyExchangeHandler(List<Contact> listOfContacts) {

        //Retrieving currency rates
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

        //Updating accounts and contacts
        List<Account> listOfAccountsToUpdate = new List<Account>();
        List<Contact> listOfContactsToUpdate = new List<Contact>();
        Decimal rateUSD = mapCurrencyToRate.get('USD');
        Decimal rateJPY = mapCurrencyToRate.get('JPY');

        //Updating contacts
        List<Id> listOfAccountsIds = new List<Id>();

        for (Contact contact : listOfContacts) {

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
            System.debug('$$$$$ listOfAccountsIds ' + listOfAccountsIds);
            System.debug('$$$$$ listOfContactsToUpdate ' + listOfContactsToUpdate);
        }

       

    }

}