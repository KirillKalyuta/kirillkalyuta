global class CurrencyExchangeTaskCallout {

    @Future(Callout=true)
    public static void currencyCallout() {

        wwwGamaSystemComWebservices.ExchangeRatesSoap getCurrentRates = new wwwGamaSystemComWebservices.ExchangeRatesSoap();
        Decimal rateUSD = getCurrentRates.GetCurrentExchangeRate('BS', 'USD', 1);
        System.debug(rateUSD);

        Currency_Rate__c rate_USD = new Currency_Rate__c();
        rate_USD.Name = 'USD';
        rate_USD.Rate__c = rateUSD;


        Decimal rateJPY = getCurrentRates.GetCurrentExchangeRate('BS', 'JPY', 1);
        System.debug(rateJPY);

        Currency_Rate__c rate_JPY = new Currency_Rate__c();
        rate_JPY.Name = 'JPY';
        rate_JPY.Rate__c = rateJPY;

        //Upsert rates
        List<Currency_Rate__c> listOfRates = new List<Currency_Rate__c>();
        listOfRates.add(rate_USD);
        listOfRates.add(rate_JPY);

        upsert listOfRates Currency_Rate__c.fields.Name;

    }

}