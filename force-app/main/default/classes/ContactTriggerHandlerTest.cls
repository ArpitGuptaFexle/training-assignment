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
        
        Account acc=new Account(Name='Aname',Domain_Name__c='@google.com');     
        insert acc;
        
        contact con=new contact(LastName='Lname',AccountId= acc.id,Email='asdfgy@google.com');
                          
    	Test.startTest();
        insert con;
       
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
    
}