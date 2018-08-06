global class CurrencyExchangeTaskSchedule implements Schedulable {

    global void execute(SchedulableContext ctx) {

        //Executing callout
        CurrencyExchangeTaskCallout.currencyCallout();

        //Executing batch
        CurrencyExchangeTaskBatch executeCurrencyBatch = new CurrencyExchangeTaskBatch();
        Database.executeBatch(executeCurrencyBatch);

    }

}