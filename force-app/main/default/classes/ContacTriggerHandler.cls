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
public class ContacTriggerHandler {

    public static final String EMAIL_ERROR = 'Email must contain the domain: ';

    public static void validateContactEmails(List<Contact> contactList) {
        
        Map<Id, Account> accountMap = new Map<Id, Account>();
        Set<Id> accountIds = new Set<Id>();
        
        for (Contact contact : contactList) {
            
            if (contact.AccountId != null && contact.Email != null )
                accountMap.put(contact.AccountId, null);
        }
        
        accountMap = new Map<Id, Account>([SELECT Id, Domain_Name__c
                                           FROM Account
                                           WHERE Id IN :accountMap.keySet() AND Domain_Name__c != null]);

        
        for (Contact contact : contactList) {
            
            Account account = accountMap.get(contact.AccountId);
            if (account != null && !contact.Email.contains(account.Domain_Name__c)) {
                    
                contact.addError(EMAIL_ERROR + account.Domain_Name__c);
            }
        }
    }
}