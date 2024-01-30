@isTest
global class OpenWeatherMapHttpCalloutMock implements HttpCalloutMock 
{
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) 
    {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"coord":{"lon":11,"lat":70},"weather":[{"id":600,"main":"Snow","description":"light snow","icon":"13n"}],"base":"stations","main":{"temp":1.81,"feels_like":-5.19,"temp_min":1.81,"temp_max":1.81,"pressure":998,"humidity":63,"sea_level":998,"grnd_level":998},"visibility":10000,"wind":{"speed":17.47,"deg":275,"gust":20.61},"snow":{"1h":0.13},"clouds":{"all":100},"dt":1706577736,"sys":{"sunrise":1706606224,"sunset":1706622066},"timezone":3600,"id":0,"name":"","cod":200}');
        response.setStatusCode(200);
        return response; 
    }
}