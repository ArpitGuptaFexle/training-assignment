public class AccountProcessor {

    public static void countContacts(List<id> listId){
        List<Account> accList =[SELECT id,Number_Of_Contacts__c,(SELECT ID FROM Contacts) FROM Account WHERE Id IN:listId];
        
        for(Account acc: accList){
            
            List<Contact> conList= acc.contacts;
            acc.Number_Of_Contacts__c=conlist.size();
        }
        
        UPDATE accList;
    }
}

//Anounymous Window
/*List<Account> accountList = [SELECT Id FROM Account LIMIT 10];
List<Id> accountIds = new List<Id>();

for (Account acc : accountList) {
    accountIds.add(acc.Id);
}

AccountProcessor.countContacts(accountIds);
*/