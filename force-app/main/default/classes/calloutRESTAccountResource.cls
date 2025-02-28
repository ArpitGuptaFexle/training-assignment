public class calloutRESTAccountResource {
    
    public static final String CONSUMER_KEY ='3MVG9VMBZCsTL9hngyLJShF.lFQ4g5PsuoPC_04Q1bU6t9wRvC6w4x2X9HX0T.cqOYSV5UkaC1egodcNdegVB';
    public static final String CONSUMER_SECRET = '7792B1ACE79DCEA627975A62747644A308873786716E7F0755EDF531FE6E4A3A';
    public static final String USERNAME = 'arpitguptaji4u@gmail.com';
	public static final String PASSWORD = 'Arpit@123wXrHXB4WR7pzIhP6rjfsKkFlJ';    
    
    public static string getUserFromExternalSystem(){
        
        String requestBody = 'grant_type=password'+'&client_id='+CONSUMER_KEY+'&client_secret='+CONSUMER_SECRET+'&username='+USERNAME+'&password='+PASSWORD;
        HTTP http = new Http();
        HTTPRequest req = new HttpRequest();
        req.setBody(requestBody);
        req.setMethod('POST');
        req.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        //req.setHeader('Content-Type','application/json');
        
        
        HTTPResponse res = http.send(req);
        System.debug('@@@@@@responseBody'+ res);
        if(res.getStatusCode() == 200){
            Map<String,Object> reponseMap = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
            System.debug(reponseMap);
            return (string)reponseMap.get('access_token');
        }
        
        return null;
        //Create User
        /*
        HTTP http = new Http();
        HTTPRequest req = new HttpRequest();
        
        req.setEndpoint('https://reqres.in/api/users');
        req.setHeader('Content-Type','application/json');
        req.setMethod('POST');
        
        req.setBody('{"name": "Arpit","job": "CEO"}');
        
        HTTPResponse res = new HTTPResponse();
        res = http.send(req);
        
        System.debug('@@@Response  '+ res+'   '+res.getBody());
        */
    }
    
    public static void InsertAccountAndContact(){
        String accessToken = getUserFromExternalSystem();
        
        String name = 'Arrrrpit';
        String fname = 'A';
        String lname = 'Gupta';
        String email = 'asah@gmail.com';
        
        HTTP http = new Http();
        HTTPRequest req = new HttpRequest();
        req.setBody('{"Name": "' + name + '", "firstName": "' + fname + '","lastName": "' + lname +'", "email": "' + email + '"}');
        req.setMethod('POST');
        req.setEndpoint('https://dns000002ygfx2aa-dev-ed.develop.my.salesforce.com/services/apexrest/AccountAPI');
        req.setHeader('Authorization','Bearer '+accessToken);
        req.setHeader('Content-Type','application/json');
        System.debug('#@#@'+req);
        
        HTTPResponse res = http.send(req);
        System.debug('######'+ res);
        System.debug(res.getBody());
    }

}