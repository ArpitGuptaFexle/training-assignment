/**
 *   Description       : Attendee Trigger Helper Class
 *
 *   Created By        : Arpit Gupta
 *
 *   Created Date      : 11/29/2024
 *
 *   Revision Logs     : V_1.0 - Created - 12 December 2024    
 * 
**/
public class AttendeeTriggerHelper {
	
    public static void handleAttendeeUpdate(List<Attendee__c> newlistRecords, Map<Id, Attendee__c> oldMapRecords) {
        
        Map<Id, Contact> mapContacts = new Map<Id, Contact>();

        for (Attendee__c att : (newlistRecords != null ? newlistRecords : oldMapRecords.values())) {

            Attendee__c oldAttendeeRecord = oldMapRecords?.get(att.Id);
            
            if((att.Contact__c != null && att.Training_Session__c != null && (oldMapRecords == null || newlistRecords == null)) ||
               att.Training_Session__c != oldAttendeeRecord.Training_Session__c || att.Contact__c != oldAttendeeRecord.Contact__c){               

                if (att.Contact__c != null) {
                    mapContacts.put(att.Contact__c, new Contact(Id = att.Contact__c, Count_Session__c = 0));
                }

                if (oldMapRecords != null && oldAttendeeRecord.Contact__c != null && att.Contact__c != oldAttendeeRecord.Contact__c) {
                    mapContacts.put(oldAttendeeRecord.Contact__c, new Contact(Id = oldAttendeeRecord.Contact__c, Count_Session__c = 0));
                }
            }
        }

        if (mapContacts.isEmpty()) 
            return ;

        List<AggregateResult> results = [
            SELECT COUNT_DISTINCT(Training_Session__c) countSession, Contact__c
            FROM Attendee__c 
            WHERE Contact__c IN :mapContacts.keySet() AND Training_Session__c != null
            GROUP BY Contact__c
        ];
        
        for (AggregateResult result : results) {
            mapContacts.put(
                (Id)result.get('Contact__c'), 
                new Contact(Id = (Id)result.get('Contact__c'), 
                            	 Count_Session__c = (Integer)result.get('countSession'))
            );
        }
        
        update mapContacts.values();
        
    }
}