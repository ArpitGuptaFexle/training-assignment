@RestResource(urlMapping='/AccountAPI/*')
global with sharing class AccountResource {
    
    @HTTPGET
    global static List<Account> getAccountNameId(){
        
        RestRequest req = RestContext.request;
        string AccountId = req.requestURI.substring(req.requestURI.lastIndexof('/')+1);
        List<Account> accList = [SELECT Id, Name FROM Account WHERE ID =: AccountId];
        return accList;
    }
    
    @HTTPPOST
    global static String postAccountAndContact(){
        
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        
        res.addHeader('ContentType','application/json');
        
        String requestBody = req.requestBody.toString();
        Map<String, Object> params = (Map<String,Object>) JSON.deserializeUntyped(requestBody);
        System.debug('Params:'+ params);
        
        String accountName = (String)params.get('Name');
        String firstName = (String)params.get('firstName');
        String lastName = (String)params.get('lastName');
        String email = (String)params.get('email');
        
        
       List<Account> exisitingacc = [SELECT Id,Name FROM Account WHERE Name =: accountName LIMIT 1]; 
       Account newAcc;
        
        if(!exisitingacc.isEmpty()){
            newAcc = exisitingacc[0];
        }else{
            newAcc = new Account(Name = accountName);
            try{
                  INSERT newAcc;
            }
            catch(DMLException e){
                System.debug('ERROR while inserting Account');
                return JSON.serialize(new Map<String,Object>{
                    'Error'=> 'Failed to create account',
                    'Message' => e.getMessage()
                });
            }
          
        }
        
        List<Contact> exisitingCon = [SELECT Id FROM Contact WHERE Email =: email AND AccountId = :newAcc.id LIMIT 1];
        if(!exisitingCon.isEmpty()){
            
            return JSON.serialize(new Map<String, Object>{
                        'Error' => 'Duplicate Contact found with the same Email or LastName on this Account\n',
                        'AccountId' => newAcc.Id+'\n'
                        });

        }
            Contact newCon = new Contact(FirstName = firstName, LastName = lastName, Email = email,AccountId = newAcc.Id);
        try{
            INSERT newCon;
        }
        catch(DMLException e){
            System.debug('Got Error while Inserting the Contact');
            return JSON.serialize(new Map<String, Object>{
                'Error'=> 'Failed to create Contact',
                 'Message' => e.getMessage()   
            });
        }     
            return JSON.serialize(new Map<String, Object>{
            		'Success' => 'Success in Creating the Account and Contact',
                    'ContactId' => newCon.Id,
                    'AccountId' => newAcc.Id              
        	});    
    }
}