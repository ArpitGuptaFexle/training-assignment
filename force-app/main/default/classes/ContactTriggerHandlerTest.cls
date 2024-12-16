/**
 *   Description       : Contact Trigger Testing Class
 *
 *   Created By        : Arpit Gupta
 *
 *   Created Date      : 11/29/2024
 *
 *   Revision Logs     : V_1.0 - Created - 11 December 2024    
 * 
**/
@isTest
public class ContactTriggerHandlerTest {
	@isTest
    static void InsertEmailValues(){
        
        Account acc=new Account(Name = 'Aname', Domain_Name__c = '@google.com');     
        insert acc;
        
        contact con=new contact(LastName = 'Lname', AccountId = acc.id, Email = 'asdfgy@google.com');
                          
    	Test.startTest();
        
        insert con;
        List<Contact> conList = [SELECT Id FROM Contact WHERE LastName = 'Lname' LIMIT 1];
        Assert.areEqual(1, conList.size(), 'Contact list size must be one'); 
        
        Test.stopTest();
        
	}
    
    @isTest
    static void InsertWrongEmailValues(){
        contact con2=new contact();
        con2.LastName='L2name';
      
        Test.startTest();
        insert con2;
        Test.stopTest();
    }
    @isTest
    static void Nullvalue(){
        Account acc=new Account(Name = 'Aname', Domain_Name__c = '@google.com');     
        insert acc;
    }
   
    @isTest
    static void TestEmailDomainError() {
        
        Account acc = new Account(Name = 'Test Account', Domain_Name__c = '@google.com');     
        insert acc;

        Contact con = new Contact(LastName = 'Doe', AccountId = acc.id, Email = 'test@example.com');
        
        Test.startTest();
        
        try {

            insert con;

            System.assert(false, 'The contact should have thrown an email domain error');
        } catch (DmlException e) {
            
            System.assert(e.getMessage().contains('Email must contain the domain: @google.com'), 
                                                  'Error message should contain the correct domain.');
        }
        
        Test.stopTest();
    }

}