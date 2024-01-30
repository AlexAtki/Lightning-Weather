public class REST_OpenWeatherMap {

    public class APIRequest_weather
    {
        public final mainInfo main;
        public final list<weatherDesc> weather;
    }
    public class mainInfo
    {
        final decimal temp, temp_min, temp_max, pressure, humidity;
    }
    public class weatherDesc
    {
        final String description;
    }
    
    public static void invokeGetWeather(List<Weather_Location__c> Locations)
    {
        system.debug('Prepping Location ids');
        Set<Id> locationIds = new Set<id>();
		for(Weather_Location__c l : locations)
        {
            locationIds.add(l.id);
        }
        REST_getAndRecordWeatherInfo(locationIds);
    }
    
    @future(callout = true)
    public static void REST_getAndRecordWeatherInfo(Set<Id> locationIds) 
    {
        System.debug('REST_getAndRecordWeatherInfo');
        List<Weather_Information__c> weatherdata = new list<Weather_Information__c>();
        Http http = new Http();
        for(Weather_Location__c location : [SELECT Id, Latitude__c,Longitude__c from  Weather_Location__c where Id in : locationIds])
        {
            HttpRequest request = new HttpRequest();
            //Would be best to stick all the endpoint paramaters into a custom setting if there was more time.
            request.setEndpoint('https://api.openweathermap.org/data/2.5/weather?lat='+location.Latitude__c+'&lon='+location.Longitude__c+'&APPID=cc26dbec66aa9b6fbff200b1255e79bd&units=metric');
            request.setMethod('GET');
            HttpResponse response = http.send(request);   
            
            if(response.getStatusCode() == 200)
            {
                APIRequest_weather newWeather = (APIRequest_weather)System.JSON.deserialize(response.getbody(), APIRequest_weather.class);  
                weatherdata.add(new Weather_Information__c(
                    Temperature__c = newWeather.main.temp,
                    Temperature_Max__c = newWeather.main.temp_max,
                    Temperature_Min__c = newWeather.main.temp_min,
                    Humidity__c = newWeather.main.humidity,
                    Pressure__c = newWeather.main.pressure,
                    Weather_Description__c = newWeather.weather[0].description,
                    Weather_Location__c = location.Id
                ));
            }
            //else handle error
        } 
        system.debug(weatherdata);
        
        //try{}catch(exception e){}
        //Error handling normally around here for rollback/feedback but none stated in assignment requirements.
        insert weatherdata;

        system.debug('REST_getAndRecordWeatherInfo - Finish');
    }
}