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
}