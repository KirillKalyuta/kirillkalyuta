@IsTest
public class TestServiceRest {
    @isTest static void getAccountsIdAndContactsId(){
        RestResponse res = new RestResponse();
        RestRequest req = new RestRequest();
        RestContext.request = req;
        RestContext.response = res;
        req.requestURI = '/ServiceRest';
        Date paramDateTime=Date.today();
        String dateToday = paramDateTime.year() + '-' + paramDateTime.month() + '-' + paramDateTime.day();
        req.params.put('date', dateToday);
        Test.startTest();
        ServiceRest.requestGet();
        Test.stopTest();
        System.assertEquals(200, res.statusCode);
    }
    @isTest static void createPost(){
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        String JSONMsg = '{"Account":[{"Name":"Sasha","Phone":"(29) 949-18-79","Contact":[{"FirstName":"Masha","LastName":"Krasnitskaya","Phone":"(33) 456-73-48"},{"FirstName":"Lesha","LastName":"Kosov","Phone":"(29) 567-84-97 "}]}]}';
        req.requestURI = '/services/apexrest/ServiceRest/'; 
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueof(JSONMsg);
        RestContext.request = req;
        RestContext.response = res;
        Test.startTest();
        ServiceRest.createObj();
        Test.stopTest();
    }
}