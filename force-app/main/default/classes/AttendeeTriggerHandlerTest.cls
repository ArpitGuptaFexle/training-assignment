@isTest
public class AttendeeTriggerHandlerTest {
    @isTest
    static void InsertAttendeeTest(){
        
        contact con =new contact(LastName='Agarwal');
        insert con;
        
        Training_Session__c ts=new Training_Session__c(Training_Topics__c='Page Layouts',Name='Test Training',RecordTypeId='012dM000003l5FRQAY');
        insert ts;
        
        Attendee__c att=new Attendee__c(Email__c='abc@gmail.com',Training_Session__c= ts.id,Contact__c=con.Id);
        
        Test.startTest();
        insert att;
        Test.stopTest();
    }
    
    @isTest
    static void updateAttendeeTest(){
        
        contact con =new contact(LastName='Agarwal');
        insert con;
        
        contact con2 =new contact(LastName='Agarwal2');
        insert con2;
        
        Training_Session__c ts=new Training_Session__c(Training_Topics__c='Page Layouts',Name='Test Training',RecordTypeId='012dM000003l5FRQAY');
        insert ts;
        
        Attendee__c att=new Attendee__c(Email__c='abc@gmail.com',Training_Session__c= ts.id,Contact__c=con.Id);
        insert att;
        
        att.Contact__c=con2.Id;
        update att;
    }
    
    @isTest
    static void deleteAttendeeTest(){
        
        contact con =new contact(LastName='Agarwal');
        insert con;
        
        contact con2 =new contact(LastName='Agarwal2');
        insert con2;
        
        Training_Session__c ts=new Training_Session__c(Training_Topics__c='Page Layouts',Name='Test Training',RecordTypeId='012dM000003l5FRQAY');        
        insert ts;
        
        Attendee__c att=new Attendee__c(Email__c='abc@gmail.com',Training_Session__c= ts.id,Contact__c=con.Id);
        insert att;
        
        att.Contact__c=con2.Id;
        delete att;
    }

}