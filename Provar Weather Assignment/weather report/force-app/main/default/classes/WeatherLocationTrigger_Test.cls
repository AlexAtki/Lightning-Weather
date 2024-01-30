@isTest
private class WeatherLocationTrigger_Test 
{
    @isTest static void testGetCallout() {
        
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new OpenWeatherMapHttpCalloutMock()); 
        
        test.startTest();
        Weather_Location__c testLocation = new Weather_Location__c(Name = 'testland', Latitude__c=3.14, Longitude__c=66.01);
        insert testLocation;
        test.stoptest();

        List<Weather_Information__c> weatherInfos = WeatherReporterController.getWeatherReport(testLocation.Id);
        system.assert(weatherInfos.size() == 1);
    }
}