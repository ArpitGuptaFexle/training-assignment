/**
 *   Description       : Contact Trigger Helper
 *
 *   Created By        : Arpit Gupta
 *
 *   Created Date      : 11/29/2024
 *
 *   Revision Logs     : V_1.0 - Created - 11 December 2024    
 * 
**/
public class ContactTriggerHelper {
    
    public static final String EMAIL_ERROR = 'Email must contain the domain: ';
    
    /**
    *   @description    :   This method used to check Domain of Email.
    *
    *   @arg            :   List<Contact> listNewContact
    *
    *   @return         :   Void
    *
    *   @Revision Log   :   V_1.0 - Created - Arpit Gupta - 12/12/2024 
    * 
    **/

    public static void checkDomainForEmail(List<Contact> listNewContact){
        
        Map<Id, Account> accountMap = new Map<Id, Account>();
        
        for (Contact contact : listNewContact){
            
            if (contact.AccountId != null && 
                contact.Email != null )
                accountMap.put(contact.AccountId, null);
        }
        
        if(accountMap.isEmpty())
            return;
        
        accountMap = new Map<Id, Account>([SELECT Id, Domain_Name__c
                                           FROM Account
                                           WHERE Id IN :accountMap.keySet() AND Domain_Name__c != null]);
        
        for (Contact contact : listNewContact) {
            
            Account account = accountMap.get(contact.AccountId);
            if (account != null && !contact.Email.contains(account.Domain_Name__c)) 
                contact.addError(EMAIL_ERROR + account.Domain_Name__c);
        }
    }
    
    /**
    *   @description    :   This method used to check Record Id and Picklist using Dynamic.
    *
    *   @arg            :   List<Contact> newConList ,  Map<Id, Contact> oldConMap
    *
    *   @return         :   Void
    *
    *   @Revision Log   :   V_1.0 - Created - Arpit Gupta - 01/07/2025 
    * 
    **/
   
    public static void checkRecordIdObjectAndPickList(List<Contact>newConList, Map<Id, Contact> oldConMap){
        
        Map<String, Schema.SObjectType> globalDescribe = Schema.getGlobalDescribe();
        
        for (Contact con : newConList) {
            
            if (String.isNotBlank(con.RecordId__c) && (con.RecordId__c.length() == 18 || con.RecordId__c.length() == 15)) {
                
                if (oldConMap == null || 
                    (oldConMap.containsKey(con.Id) && con.RecordId__c != oldConMap.get(con.Id).RecordId__c)) {
                        
                        Id recordId = con.RecordId__c;
                        Schema.SObjectType sobjectType = recordId.getSObjectType();
                        
                        con.Object_Name__c = sobjectType.getDescribe().getLabel();
                        
                        List<String> fieldNames = new List<String>();
                        Schema.DescribeSObjectResult describeResult = sobjectType.getDescribe();
                        Map<String, Schema.SObjectField> fieldsMap = describeResult.fields.getMap();
                        
                        for (String fieldName : fieldsMap.keySet()) {
                            Schema.DescribeFieldResult fieldResult = fieldsMap.get(fieldName).getDescribe();
                            if (fieldResult.getType() == Schema.DisplayType.Picklist) {
                                
                                fieldNames.add(fieldName); 
                            }
                		}
                        con.Picklist_Field__c = string.join(fieldNames,'\n');
                        
                }
            }
        } 
        /*
        Map<String, Schema.SObjectType> globalDescribe = Schema.getGlobalDescribe();
        
        for(Contact con : newConList){
            
            if(!String.isBlank(con.RecordId__c) && con.RecordId__c.length() == 18){
                
                if(oldConMap == Null || (oldConMap.containsKey(con.Id) && con.RecordId__c != oldConMap.get(con.Id).RecordId__c)){
                    
                    String prefix = con.RecordId__c.substring(0, 3);
                    
                    for(Schema.SObjectType sobjectType : globalDescribe.values()){
                        
                        if(sobjectType.getDescribe().getKeyPrefix() == prefix){
                            
                            con.Object_Name__c = sobjectType.getDescribe().getLabel();
                            break;
                            
                        }
                        
                    }
                    
                }
            }
        }
		*/
    }
}