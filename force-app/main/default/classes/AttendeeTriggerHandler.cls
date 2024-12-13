/**
 *   Description       : Attendee Trigger Handler Class
 *
 *   Created By        : Arpit Gupta
 *
 *   Created Date      : 11/29/2024
 *
 *   Revision Logs     : V_1.0 - Created - 11 December 2024    
 * 
**/
public class AttendeeTriggerHandler extends TriggerHandler{
    
    public override void afterInsert() {
        
		AttendeeTriggerHelper.handleAttendeeUpdate((List<Attendee__c>)trigger.new,(Map<Id,Attendee__c>)trigger.oldMap);    
    }
    
    public override void afterUpdate() { 
        
		AttendeeTriggerHelper.handleAttendeeUpdate((List<Attendee__c>)trigger.new,(Map<Id,Attendee__c>)trigger.oldMap);    
    }
    
    public override void afterDelete() {
        
		AttendeeTriggerHelper.handleAttendeeUpdate((List<Attendee__c>)trigger.new,(Map<Id,Attendee__c>)trigger.oldMap);    
    }
}