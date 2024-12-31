/**
 *   Description       : This is for Future Job Assignment Test (AccountProcessorTest)
 *
 *   Created By        : Arpit Gupta
 *
 *   Created Date      : 12/18/2024
 *
 *   Revision Logs     : V_1.0 - Created - Apex Ass4
 * 
**/
@isTest
public class AccountProcessorTest {
    @isTest
    private static void CountContactTest(){
        List<Account> accList = new List<Account>();
        for(Integer i = 0;i<250;i++){
            accList.add(new Account(Name = 'Test'+i));
        }
        
        Test.startTest();
        insert accList;
        
        List<Contact> conList = new List<Contact>();
        Set<Id> accIds = new Set<id>();
        
        for(Account acc: accList){
            Contact con = new Contact();
            con.FirstName = 'Test';
            con.LastName = acc.Name;
            con.AccountId = acc.id;
            conList.add(con);
            accIds.add(acc.Id);
        }
        
        insert conList;
        AccountProcessor.countContacts(accIds);
        Test.stopTest();
        
        List<Account> accs=[SELECT Id,Number_Of_Contacts__c FROM Account];
        
        Assert.areEqual(1,accs[0].Number_Of_Contacts__c,'Actual Count of Contact Should be 1 but it Showing'+accs[0]);   
    }
}