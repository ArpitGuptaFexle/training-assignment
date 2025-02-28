global class SmartyStreetAPIContactTriggerHandler {

    public static void verifyContactMailingAdress(List<Contact> conList){
        set<Id> setAPI = new Set<Id>();
		if(!conList.isEmpty()){
            for(Contact con: conList){
                if(con.MailingStreet != NULL && con.MailingState!= NULL){
                    setAPI.add(con.Id);
                }
        }
            checkAPI(setAPI);
        }
    }
    
    @future(callout=true)
    public static void checkAPI(set<Id> contactId){
        System.debug('@@@start');
		Set<Id> contactIdsUpdate = new Set<Id>();
        for(Contact con : [SELECT Id,MailingCity, MailingStreet,MailingState, Verified_Adrress__c FROM Contact WHERE Id = :contactId]){
            
            
            String street = EncodingUtil.urlEncode(con.MailingStreet, 'UTF-8');
            String city = EncodingUtil.urlEncode(con.MailingCity, 'UTF-8');
            String state = EncodingUtil.urlEncode(con.MailingState, 'UTF-8');
            
            Http http = new Http();
        	HTTPRequest req = new HttpRequest();

            req.setEndpoint('https://us-street.api.smartystreets.com/street-address?auth-id=7f17e288-d1ad-965b-df69-2082634e22ab&auth-token=31eo21fuRZd2p7T5J9WD&street='+street+'&state='+state+'&city='+city +'&candidates=10&match=enhanced');
            req.setMethod('GET');
            HttpResponse res = http.send(req);
            System.debug('@@@respone'+res);
            if(res.getStatusCode() == 200){
                String responseBodyy = res.getBody();
                if(!responseBodyy.contains('[]')){
                    contactIdsUpdate.add(con.Id);  
                }     
            }
            
        }
        updateCon(contactIdsUpdate);
       
        //req.setHeader('Content-Type','application/json');
    }
    
    public static void updateCon(Set<Id> contactIdsUpdate){
        
       List<Contact> contactToUpdate = new List<Contact>();
        
        for(Id newCon : contactIdsUpdate){
            
            Contact con = new Contact();
            con.Id = newCon;
            con.Verified_Adrress__c = true;
            contactToUpdate.add(con);
            System.debug(con);
        }
        
        update contactToUpdate;
        
    }
}