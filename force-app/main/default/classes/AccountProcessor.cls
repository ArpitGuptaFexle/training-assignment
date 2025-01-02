/**
 *   Description       : This is for Future Job Assingment (Account Processor)
 *
 *   Created By        : Arpit Gupta
 *
 *   Created Date      : 12/18/2024
 *
 *   Revision Logs     : V_1.0 - Created - Apex Ass4
 * 
**/
public class AccountProcessor {
	@future
    public static void countContacts(Set<id> setId){
        List<Account> accList =[SELECT id,Number_Of_Contacts__c,(SELECT Id FROM Contacts) 
                                FROM Account 
                                WHERE Id IN:setId];
        
        for(Account acc: accList){
    
            acc.Number_Of_Contacts__c=acc.contacts.size();
        }
        
        if(!accList.isEmpty())
        update accList;
    }
}

//Anounymous Window
/* 
    List<Account> accountList = [SELECT Id FROM Account LIMIT 10];
    Set<Id> accountIds = new Set<Id>();
    
    for (Account acc : accountList) {
        accountIds.add(acc.Id);
    }
    
    AccountProcessor.countContacts(accountIds);
*/