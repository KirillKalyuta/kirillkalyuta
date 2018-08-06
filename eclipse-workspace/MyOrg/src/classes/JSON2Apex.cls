public class JSON2Apex {

	public class Account {
		public String name;
  		public String email;
  		public List<Contact> contact;
 	}

 	public List<Account> account;

 	public class Contact {
  		public String LastName;
  		public String FirstName;
  		public String Email;
 	}

 
 	public static JSON2Apex parse(String json) {
  		return (JSON2Apex) System.JSON.deserialize(json, JSON2Apex.class);
 	}
}