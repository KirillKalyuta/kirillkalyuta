public class UpdateContactGeoCod {
	@future(callout=true)
	static public void newConMethod(set<id> li){
        
		for(Contact con : [SELECT MailingCity, MailingCountry, MailingPostalCode, MailingState, MailingStreet 
                         FROM Contact 
                         WHERE id =: li]){
			String address = '+';
			if (con.MailingStreet != null)
			address += con.MailingStreet +'+';
			if (con.MailingCity != null)
			address += con.MailingCity +'+';
			if (con.MailingState != null)
			address += con.MailingState +'+';
			if (con.MailingPostalCode != null)
            address += con.MailingPostalCode +'+';
			if (con.MailingCountry != null)
			address += con.MailingCountry;
            system.debug(address);                 
            address.replace('/n', '+');
            system.debug(address);                
			address = EncodingUtil.urlEncode(address, 'UTF-8');
			system.debug(address);                
            // build callout
		Http h = new Http();
		HttpRequest req = new HttpRequest();
        String API_KEY = 'AIzaSyB_p06K0cfNSHKiZUCC_agOjQIWeSieCKw';
		req.setEndpoint('https://maps.googleapis.com/maps/api/geocode/json?address=' + address +'&key'+ API_KEY); //string.format
		req.setMethod('GET');
		try{
			// callout
			HttpResponse res = h.send(req);
            Map<String, Object> resp = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
        	Map<String, Object> query= new Map<String, Object>();
            System.debug(resp);
			// parse coordinates from response
			JSONParser parser = JSON.createParser(res.getBody());
			double lat = null;
			double lon = null;
			while (parser.nextToken() != null) {
				if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) &&
				(parser.getText() == 'location')){
					parser.nextToken(); // object start
				while (parser.nextToken() != JSONToken.END_OBJECT){
					String txt = parser.getText();
					parser.nextToken();
					if (txt == 'lat')
					lat = parser.getDoubleValue();
				else if (txt == 'lng')
				lon = parser.getDoubleValue();
				}
			}
		}
		// update coordinates if we get back
		if (lat != null){
			system.debug(lat+ ' ' +lon);
			con.Location__Latitude__s = lat;
			system.debug(con.Location__Latitude__s + ' MailingLatitude');
			con.Location__Longitude__s  = lon;
			system.debug(con.Location__Longitude__s  + ' MailingLongitude');
			update con;
		}
	}
	catch (Exception e) {
		system.debug(e);
			}
		}
	}
}