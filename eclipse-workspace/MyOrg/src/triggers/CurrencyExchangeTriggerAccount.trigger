trigger CurrencyExchangeTriggerAccount on Account (before insert, before update) {

    CurrencyExchangeTaskHandlerAccount.CurrencyExchangeHandlerAccount(Trigger.new);
    
}