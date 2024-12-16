@isTest
public class AccountProcessorTest {
	@isTest
    public static void TestAccountProcessTest(){
        Account a=new Account(Name='Account Test');
        Insert a;
        
        Contact  cont= new contact(FirstName='Bob',LastName='Test',AccountId=a.Id);
        Insert cont;
        
        Contact cont1=new contact(FirstName='Suresh',LastName='Test',AccountId=a.Id);
        Insert cont1;
        
        list<id> accId=new list<Id>();
        accId.add(a.Id);
        
        Test.startTest();
        AccountProcessor.countContacts(accId);
        Test.stopTest();
        
        Account ACC = [select Number_of_Contacts__c from Account where id = :a.id LIMIT 1];
        System.assertEquals ( Integer.valueOf(ACC.Number_of_Contacts__c) ,2);
        
    }
}