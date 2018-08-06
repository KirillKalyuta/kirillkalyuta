public class WeatherInfoController { 
	public static List<WeatherWrapper> weaths { 
		get{ 
			return WeatherWrapper.getWeather(); 
			} 
		set{ 
		} 
	} 
	public WeatherInfoController() { 
	} 
}