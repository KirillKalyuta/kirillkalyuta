public class weather {

	public class Condition {
		public String text;
		public String icon;
		public Integer code;
	}

	public Location location;
	public Current current;
	public Forecast forecast;

	public class Astro {
		public String sunrise;
		public String sunset;
		public String moonrise;
		public String moonset;
	}

	public class Forecast {
		public List<Forecastday> forecastday;
	}

	public class Forecastday {
		public String date1;
		public Integer date_epoch;
		public Day day;
		public Astro astro;
	}

	public class Current {
		public Integer last_updated_epoch;
		public String last_updated;
		public Double temp_c;
		public Double temp_f;
		public Integer is_day;
		public Condition condition;
		public Double wind_mph;
		public Double wind_kph;
		public Integer wind_degree;
		public String wind_dir;
		public Double pressure_mb;
		public Double pressure_in;
		public Double precip_mm;
		public Double precip_in;
		public Integer humidity;
		public Integer cloud;
		public Double feelslike_c;
		public Double feelslike_f;
		public Double vis_km;
		public Double vis_miles;
	}

	public class Day {
		public Double maxtemp_c;
		public Double maxtemp_f;
		public Double mintemp_c;
		public Double mintemp_f;
		public Double avgtemp_c;
		public Double avgtemp_f;
		public Double maxwind_mph;
		public Double maxwind_kph;
		public Double totalprecip_mm;
		public Double totalprecip_in;
		public Double avgvis_km;
		public Double avgvis_miles;
		public Double avghumidity;
		public Condition condition;
		public Double uv;
	}

	public class Location {
		public String name;
		public String region;
		public String country;
		public Double lat;
		public Double lon;
		public String tz_id;
		public Integer localtime_epoch;
		public String localtime;
	}

	
	public static weather parse(String json) {
		return (weather) System.JSON.deserialize(json, weather.class);
	}
}