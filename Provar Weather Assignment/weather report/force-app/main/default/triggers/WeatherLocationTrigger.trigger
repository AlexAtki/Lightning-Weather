trigger WeatherLocationTrigger on Weather_Location__c (after insert) 
{
    System.debug('WeatherLocationTrigger');
    //static Trigger_Settings__c ts = Trigger_Settings__c.getOrgDefaults();

    //if(ts.Enable_Location_Trigger__c)
    //{
        if (Trigger.isAfter && Trigger.isInsert){
            system.debug('WeatherLocationTrigger - After Insert');
            WeatherLocationTriggerHandler.afterInsert(Trigger.new);
        }
    //}   
}