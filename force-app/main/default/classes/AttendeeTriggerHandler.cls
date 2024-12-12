public class AttendeeTriggerHandler {

    
    public static void handleAttendeeUpdate(List<Attendee__c> newlistRecords, 
                                            List<Attendee__c> oldlistRecords, Map<Id, Attendee__c> oldMapRecords) {
        
        Map<Id, Contact> mapContacts = new Map<Id, Contact>();

        for (Attendee__c att : (newlistRecords != null ? newlistRecords : oldlistRecords)) {

            Attendee__c oldAttendeeRecord = oldMapRecords != null ? oldMapRecords.get(att.Id) : null;

            if (att.Contact__c != null && att.Training_Session__c != null  //Insert and
                && (oldMapRecords == null || newlistRecords == null ||     //Update
                 (att.Training_Session__c != oldAttendeeRecord.Training_Session__c || //delete
                  att.Contact__c != oldAttendeeRecord.Contact__c))) {                 //operation

                if (att.Contact__c != null) {
                    mapContacts.put(att.Contact__c, new Contact(Id = att.Contact__c, Count_Session__c = 0));
                }

                if (oldMapRecords != null && oldAttendeeRecord.Contact__c != null && att.Contact__c != oldAttendeeRecord.Contact__c) {
                    mapContacts.put(oldAttendeeRecord.Contact__c, new Contact(Id = oldAttendeeRecord.Contact__c, Count_Session__c = 0));
                }
            }
        }

        if (!mapContacts.isEmpty()) {

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

            if (!mapContacts.isEmpty()) {
                update mapContacts.values();
            }
        }
    }
}