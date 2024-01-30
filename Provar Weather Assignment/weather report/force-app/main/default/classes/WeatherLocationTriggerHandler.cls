public class WeatherLocationTriggerHandler 
{
    public static void afterInsert(List<Weather_Location__c> locations) 
    {
        System.debug('LocationTriggerHandler - afterInsert');
        REST_OpenWeatherMap.invokeGetWeather(locations);
        system.debug('test');
    }
}