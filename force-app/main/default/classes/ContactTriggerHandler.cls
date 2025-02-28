/**
 *   Description       : Trigger Handler for Contact
 *
 *   Created By        : Arpit Gupta
 *
 *   Created Date      : 12/04/2024
 *
 *   Revision Logs     : V_1.0 - Created - Apex Assignment 3     
 * 
**/
public class ContactTriggerHandler extends TriggerHandler {
    
    /**
    *   @description    :   This method used to for beforeInsert for Check Domain.
    *
    *   @arg            :   
    *
    *   @return         :   Void
    *
    *   @Revision Log   :   V_1.0 - Created - Arpit Gupta - 12/12/2024 
    * 
    **/
	
    /*
    public override void beforeInsert() {
        
		ContactTriggerHelper.checkDomainForEmail((List<Contact>)trigger.new);
        ContactTriggerHelper.checkRecordIdObjectAndPickList((List<Contact>)trigger.new, (Map<Id,Contact>)trigger.oldMap);
    } */
    
    /**
    *   @description    :   This method used to do beforeUpdate to check RecordIdObject And PickList.
    *
    *   @arg            :   
    *
    *   @return         :   Void
    *
    *   @Revision Log   :   V_1.0 - Created - Arpit Gupta - 01/07/2025 
    * 
    **/
    /*
    public override void beforeUpdate(){
        ContactTriggerHelper.checkRecordIdObjectAndPickList((List<Contact>)trigger.new, (Map<Id,Contact>)trigger.oldMap);

    }*/
    
    public static void checkCountContact(List<Contact> conList, Map<Id, Contact>  oldConMap){
        
        set<Id> accId = new set<Id>();
        
        for(Contact con: conList!= NULL? conList : oldConMap.values()){
            
            if(con.AccountId != NULL){
                accId.add(con.AccountId);
                
                if(oldConMap != NULL && con.AccountId != oldConMap.get(con.Id).AccountId){
                    
                    accId.add(oldConMap.get(con.Id).AccountId);
                }
            }
        }
        List<Account> accList = new List<Account>();
        if(!accId.isEmpty()){
            
            for(Account acc: [SELECT Id,Count_Number__c ,(SELECT Id FROM Contacts) FROM Account WHERE Id In: accId]){
                
                acc.Count_Number__c = acc.contacts.size();
                accList.add(acc);
                
            }
        }
        
        if(!accList.isEmpty()){
            try{
                UPDATE accList;
            }
            catch(DMLException e){
                System.debug('@@@error' + e);
            }
        }
        
    }
}