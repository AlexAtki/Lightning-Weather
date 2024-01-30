Public without sharing class WeatherReporterController {
    
    @AuraEnabled(cacheable=true)
    public static List<Weather_Information__c> getWeatherReport(String LocationRecordId) 
    {
        List<Weather_Information__c> weatherInfo = 
            [SELECT Id,
             Name,
             Temperature__c,
             Temperature_Max__c,
             Temperature_Min__c,
             Humidity__c,
             Pressure__c,
             Weather_Description__c
             FROM Weather_Information__c 
             WHERE Weather_Location__c =: LocationRecordId 
             ORDER BY createddate DESC 
             LIMIT 1];
        
        return weatherInfo;
    }
}