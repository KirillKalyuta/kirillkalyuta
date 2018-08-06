trigger CurrencyExchangeTaskTrigger on Contact (before insert, before update) {

    CurrencyExchangeTaskHandler.CurrencyExchangeHandler(Trigger.new);

}