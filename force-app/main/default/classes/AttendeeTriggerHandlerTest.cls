/**
 *   Description       : Attendee Trigger Test
 *
 *   Created By        : Arpit Gupta
 *
 *   Created Date      : 11/29/2024
 *
 *   Revision Logs     : V_1.0 - Created - 11 December 2024
 *
 **/
@isTest
public class AttendeeTriggerHandlerTest {
    @isTest
    static void InsertAttendeeTest(){
        
        Contact con =new Contact(LastName = 'Agarwal');
        insert con;
        
        Training_Session__c ts = new Training_Session__c(Training_Topics__c = 'Page Layouts', 
                                                         Name = 'Test Training' 
                                                         );
        insert ts;
        
        Attendee__c att = new Attendee__c(Email__c = 'abc@gmail.com', 
                                          Training_Session__c = ts.id, 
                                          Contact__c = con.Id);
        
        Test.startTest();

        insert att;
        List<Contact> attList = [SELECT Id, Count_Session__c FROM Contact];
        Assert.areEqual(1, attList[0].Count_Session__c, 'Contact Count Sesion must be 1');
        
        Test.stopTest();
    }
    
    @isTest
    static void updateAttendeeTest() {
        List<Contact> contactsToInsert = new List<Contact>();
        
        Contact con1 = new Contact(LastName='Agarwal');
        contactsToInsert.add(con1);
        
        Contact con2 = new Contact(LastName='Agarwal2');
        contactsToInsert.add(con2);
        
        insert contactsToInsert;
        
        Training_Session__c ts = new Training_Session__c(
            Training_Topics__c='Page Layouts',
            Name='Test Training'
        );
        insert ts;
        
        List<Attendee__c> attendeesToInsert = new List<Attendee__c>();
        
        Attendee__c att = new Attendee__c(
            Email__c='abc@gmail.com',
            Training_Session__c=ts.Id,
            Contact__c=con1.Id
        );
        attendeesToInsert.add(att);
        
        insert attendeesToInsert;
        
        att.Contact__c = con2.Id;
        
        Test.startTest();
        
        update att;
        
        List<Contact> attList = [SELECT Id, Count_Session__c FROM Contact WHERE LastName = 'Agarwal2'];
        
        System.assertEquals(1, attList[0].Count_Session__c, 'Contact Count Session must be 1');
        
        Test.stopTest();
    }

    
    @isTest
    static void deleteAttendeeTest() {
        List<Contact> contactsToInsert = new List<Contact>();
        
        Contact con1 = new Contact(LastName='Agarwal');
        contactsToInsert.add(con1);
        
        Contact con2 = new Contact(LastName='Agarwal2');
        contactsToInsert.add(con2);
        
        insert contactsToInsert;
        
        Training_Session__c ts = new Training_Session__c(
            Training_Topics__c='Page Layouts',
            Name='Test Training', 
            RecordTypeId='012dM000003l5FRQAY'
        );
        insert ts;
        
        List<Attendee__c> attendeesToInsert = new List<Attendee__c>();
        
        Attendee__c att = new Attendee__c(
            Email__c='abc@gmail.com',
            Training_Session__c=ts.Id,
            Contact__c=con1.Id
        );
        attendeesToInsert.add(att);
        
        insert attendeesToInsert;
        
        att.Contact__c = con2.Id;
        
        Test.startTest();
        
        delete att;
        
        List<Contact> attList = [SELECT Id, Count_Session__c FROM Contact];
        System.assertEquals(0, attList[0].Count_Session__c, 'Contact Count Session must be 0');
        
        Test.stopTest();
    }

    
    @isTest
	static void handleEmptyContactMapTest() {

        Contact con = new Contact(LastName = 'Agarwal');
        insert con;
    
        Training_Session__c ts = new Training_Session__c(Training_Topics__c = 'Page Layouts', 
                                                         Name = 'Test Training',
                                                         RecordTypeId = '012dM000003l5FRQAY');
        insert ts;
    
        Attendee__c att = new Attendee__c(Email__c = 'abc@gmail.com', 
                                          Training_Session__c = ts.id, 
                                          Contact__c = con.Id);
        insert att;
    
        Test.startTest();
    
        AttendeeTriggerHelper.handleAttendeeUpdate(new List<Attendee__c>(), new Map<Id, Attendee__c>());
    
        Contact updatedContact = [SELECT Id, Count_Session__c FROM Contact WHERE Id = :con.Id];
        Assert.areEqual(1, updatedContact.Count_Session__c, 
                        'Count_Session__c should not have been updated, mapContacts was empty.');
    
        Test.stopTest();
	}
}