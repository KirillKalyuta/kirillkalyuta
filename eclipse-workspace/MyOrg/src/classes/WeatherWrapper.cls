public class WeatherWrapper {   
    public static List<WeatherWrapper> weaths {get;set;}
    public  String town {get;set;}
    public  Double tempMin {get;set;}
    public  Double tempMax {get;set;}
    public  Date date1 {get;set;}   
    
    public static List<WeatherWrapper> getWeather() { 
        List<WeatherWrapper> weaths1 = new List<WeatherWrapper>();
        String apiKey = '1a7c153ebf7c4076849113103182806';
        String requestEndpoint = 'https://api.apixu.com/v1/forecast.json';
        requestEndpoint += '?q=Minsk' ;
        requestEndpoint += '&key=' + apiKey;
        requestEndpoint += '&days=' + 3;
        system.debug(requestEndpoint);
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(requestEndpoint);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        weather res = weather.parse(response.getBody());
        WeatherWrapper weathTod = new WeatherWrapper();
        weathTod.date1 = date.today();
        weathTod.town = res.Location.name;
        weathTod.tempMax = res.Forecast.forecastday[0].day.maxtemp_c;
        weathTod .tempMin = res.Forecast.forecastday[0].day.mintemp_c;
        System.debug(weathTod.date1);
        System.debug(weathTod .tempMin);
        System.debug(weathTod.town);
        weaths1.add(weathTod);
        
        WeatherWrapper weathTom = new WeatherWrapper();
        weathTom.date1 = weathTod.date1.addDays(1);
        weathTom.town = res.Location.name;
        weathTom.tempMax = res.Forecast.forecastday[1].day.maxtemp_c;
        weathTom .tempMin = res.Forecast.forecastday[1].day.mintemp_c;
        weaths1.add(weathTom);
        
        WeatherWrapper weathAfterTom = new WeatherWrapper();
        weathAfterTom.date1 = weathTod.date1.addDays(2);
        weathAfterTom.town = res.Location.name;
        weathAfterTom.tempMax = res.Forecast.forecastday[2].day.maxtemp_c;
        weathAfterTom .tempMin = res.Forecast.forecastday[2].day.mintemp_c;
        weaths1.add(weathAfterTom);
        
        weaths = weaths1;
		return weaths;
    }    
}